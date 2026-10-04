import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/helpers/media_url.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/back_title_header.dart';
import 'package:coach_space/features/student/profile/data/models/user_profile_model.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_state.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserProfileModel? _profile;
  bool _prefilled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _applyProfile(UserProfileModel profile) {
    _profile = profile;
    if (_prefilled) return;
    _prefilled = true;
    _nameController.text = profile.fullName ?? '';
    _emailController.text = profile.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final l10n = context.l10n;
          final messenger = ScaffoldMessenger.of(context);

          switch (state) {
            case ProfileLoadSuccess(:final profile):
            case ProfileSaveSuccess(:final profile):
            case ProfileAvatarSuccess(:final profile):
              setState(() => _applyProfile(profile));
            case ProfileSaveFailure():
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.profileInfoSaveFailed)),
              );
            case ProfileAvatarFailure():
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.profileInfoAvatarFailed)),
              );
            case ProfileEmailChangeSuccess():
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.profileInfoEmailChangeSent)),
              );
            case ProfileEmailChangeFailure(:final message):
              messenger.showSnackBar(SnackBar(content: Text(message)));
            default:
              break;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadFailure && _profile == null) {
            return Scaffold(
              backgroundColor: AppColors.bgDefault,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizedFailureMessage(
                          context,
                          state.kind,
                          state.message,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ProfileCubit>().loadProfile(),
                        child: Text(context.l10n.commonRetry),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (_profile == null) {
            return const Scaffold(
              backgroundColor: AppColors.bgDefault,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }

          final isSaving =
              state is ProfileSaving ||
              state is ProfileAvatarUploading ||
              state is ProfileEmailChangeLoading;

          return _buildContent(
            context,
            avatar: _profile!.avatar ?? '',
            isSaving: isSaving,
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required String avatar,
    required bool isSaving,
  }) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            BackTitleHeader(
              title: l10n.profileInfoTitle,
              titleFontSize: 21,
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AvatarCard(
                      avatar: avatar,
                      name: _nameController.text,
                      isUploading: isSaving,
                      onTap: () => _pickAvatar(context),
                    ),
                    const SizedBox(height: 20),
                    _fieldLabel(l10n.profileInfoFullName),
                    const SizedBox(height: 7),
                    _textField(controller: _nameController),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        Text(
                          l10n.profileInfoEmail,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF263C38),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: isSaving
                              ? null
                              : () => _showEmailChangeDialog(context),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            l10n.profileInfoChange,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF168F82),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    _textField(controller: _emailController, readOnly: true),
                    const SizedBox(height: 6),
                    Text(
                      l10n.profileInfoEmailNote,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF8A9995),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : () => _save(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                l10n.profileInfoSaveChanges,
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAvatar(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final cubit = context.read<ProfileCubit>();

    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked == null) return;
      await cubit.uploadAvatar(File(picked.path));
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.profileInfoAvatarFailed)),
      );
    }
  }

  Future<void> _save(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.profileInfoNameRequired)),
      );
      return;
    }

    await context.read<ProfileCubit>().saveProfile(fullName: name);
  }

  Future<void> _showEmailChangeDialog(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<ProfileCubit>();

    final newEmail = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return _EmailChangeDialog(
          title: l10n.profileInfoChangeEmail,
          hint: l10n.profileInfoNewEmail,
          cancelLabel: l10n.commonCancel,
          saveLabel: l10n.commonSave,
        );
      },
    );

    if (newEmail == null || newEmail.isEmpty) return;
    await cubit.requestEmailChange(newEmail);
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF263C38),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return SizedBox(
      height: 47,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF344842)),
        decoration: InputDecoration(
          filled: true,
          fillColor: readOnly ? const Color(0xFFF3F7F6) : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFDCE5E3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFDCE5E3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

class _EmailChangeDialog extends StatefulWidget {
  const _EmailChangeDialog({
    required this.title,
    required this.hint,
    required this.cancelLabel,
    required this.saveLabel,
  });

  final String title;
  final String hint;
  final String cancelLabel;
  final String saveLabel;

  @override
  State<_EmailChangeDialog> createState() => _EmailChangeDialogState();
}

class _EmailChangeDialogState extends State<_EmailChangeDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: widget.hint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: Text(widget.saveLabel),
        ),
      ],
    );
  }
}

class _AvatarCard extends StatelessWidget {
  const _AvatarCard({
    required this.avatar,
    required this.name,
    required this.isUploading,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final bool isUploading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final url = resolveMediaUrl(avatar);
    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBE9)),
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 58,
              height: 58,
              child: url.isEmpty
                  ? _initialAvatar(initial)
                  : Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _initialAvatar(initial),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.profileInfoAvatar,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF182B28),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.profileInfoAvatarHint,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    height: 1.35,
                    color: const Color(0xFF71807C),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.profileInfoAvatarFormat,
                  style: GoogleFonts.inter(
                    fontSize: 8.5,
                    color: const Color(0xFF8A9995),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: isUploading ? null : onTap,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDCE7E4)),
              ),
              child: isUploading
                  ? const Padding(
                      padding: EdgeInsets.all(11),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      Icons.cloud_upload_outlined,
                      size: 21,
                      color: Color(0xFF075E4D),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _initialAvatar(String initial) {
    return Container(
      color: const Color(0xFF075E4D),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
