import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/profile/logic/cubit/profile_state.dart';

import 'package:coach_space/features/profile/ui/widgets/settings/avatar_section.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_field.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_header.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_tabs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobTitleController = TextEditingController();

  final _picker = ImagePicker();

  bool _didSeed = false;
  String? _avatarUrl;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  void _seedFromProfile(ProfileState state) {
    final profile = switch (state) {
      ProfileLoadSuccess(:final profile) => profile,
      ProfileSaveSuccess(:final profile) => profile,
      ProfileAvatarSuccess(:final profile) => profile,
      _ => null,
    };

    if (profile == null) return;

    if (!_didSeed) {
      _fullNameController.text = profile.fullName ?? '';
      _emailController.text = profile.email ?? '';
      _avatarUrl = profile.avatar;
      _didSeed = true;
    } else if (
    state is ProfileSaveSuccess ||
        state is ProfileAvatarSuccess
    ) {
      if (profile.fullName != null) {
        _fullNameController.text = profile.fullName!;
      }

      if (profile.avatar != null) {
        _avatarUrl = profile.avatar;
      }

      if (profile.email != null) {
        _emailController.text = profile.email!;
      }
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 11,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _pickAndUploadAvatar() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );

    if (picked == null) return;
    if (!mounted) return;

    await context
        .read<ProfileCubit>()
        .uploadAvatar(File(picked.path));
  }

  Future<void> _showChangeEmailDialog() async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final l10n = context.l10n;

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            l10n.settingsChangeEmailTitle,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textBody,
            ),
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.inter(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                labelText: l10n.settingsNewEmailLabel,
                labelStyle: GoogleFonts.inter(
                  fontSize: 11,
                ),
                hintText: 'name@example.com',
                hintStyle: GoogleFonts.inter(
                  fontSize: 11,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter your new email';
                }

                if (!value.contains('@')) {
                  return 'Enter a valid email';
                }

                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                l10n.settingsCancel,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() ??
                    false) {
                  Navigator.pop(
                    dialogContext,
                    controller.text.trim(),
                  );
                }
              },
              child: Text(
                l10n.settingsSend,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result == null || result.isEmpty) return;
    if (!mounted) return;

    await context
        .read<ProfileCubit>()
        .requestEmailChange(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        _seedFromProfile(state);

        switch (state) {
          case ProfileSaveSuccess():
            _showSnack(
              context.l10n.settingsSaveSuccess,
            );

          case ProfileSaveFailure(:final message):
            _showSnack(message);

          case ProfileAvatarSuccess():
            _showSnack(
              context.l10n.settingsAvatarUpdated,
            );
            setState(() {});

          case ProfileAvatarFailure(:final message):
            _showSnack(message);

          case ProfileEmailChangeSuccess():
            _showSnack(
              context.l10n.settingsEmailChangeSent,
            );

          case ProfileEmailChangeFailure(:final message):
            _showSnack(message);

          case ProfileEmailConfirmSuccess():
            _showSnack(
              context.l10n.settingsSaveSuccess,
            );

          case ProfileEmailConfirmFailure(:final message):
            _showSnack(message);

          case ProfileLoadFailure(:final message):
            _showSnack(message);

          default:
            break;
        }
      },

      builder: (context, state) {
        final isInitialLoading =
            state is ProfileLoading && !_didSeed;

        final isSaving =
        state is ProfileSaving;

        final isAvatarUploading =
        state is ProfileAvatarUploading;

        final isEmailChanging =
        state is ProfileEmailChangeLoading;

        // =====================================================
        // INITIAL LOADING
        // =====================================================

        if (isInitialLoading) {
          return Scaffold(
            backgroundColor: AppColors.bgDefault,
            body: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      20,
                      16,
                      30,
                    ),
                    child: SettingsHeader(),
                  ),

                  const SizedBox(height: 18),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: SettingsTabs(),
                  ),

                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // =====================================================
        // LOAD ERROR
        // =====================================================

        if (state is ProfileLoadFailure && !_didSeed) {
          return Scaffold(
            backgroundColor: AppColors.bgDefault,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 42,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 14),

                      FilledButton.icon(
                        onPressed: () {
                          context
                              .read<ProfileCubit>()
                              .loadProfile();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 17,
                        ),
                        label: Text(
                          'Retry',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // =====================================================
        // MAIN SCREEN
        // =====================================================

        return Scaffold(
          backgroundColor: AppColors.bgDefault,

          body: SafeArea(
            child: Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    10,
                    8,
                    16,
                    4,
                  ),
                  child: SettingsHeader(),
                ),

                const SizedBox(height: 18),

                // =================================================
                // SCROLLABLE CONTENT
                // =================================================

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      30,
                    ),

                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 600,
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            // =================================================
                            // TABS
                            // =================================================

                            const SettingsTabs(),

                            const SizedBox(height: 22),

                            // =================================================
                            // AVATAR
                            // =================================================

                            AvatarSection(
                              imageUrl: _avatarUrl,
                              isUploading:
                              isAvatarUploading,
                              onTap:
                              _pickAndUploadAvatar,
                            ),

                            const SizedBox(height: 22),

                            // =================================================
                            // FULL NAME
                            // =================================================

                            SettingsField(
                              label: 'Full Name',
                              controller:
                              _fullNameController,
                            ),

                            const SizedBox(height: 16),

                            // =================================================
                            // EMAIL
                            // =================================================

                            SettingsField(
                              label: 'Email Address',
                              controller:
                              _emailController,
                              showChange: true,
                              onChangeTap:
                              isEmailChanging
                                  ? null
                                  : _showChangeEmailDialog,
                            ),

                            if (isEmailChanging) ...[
                              const SizedBox(height: 7),

                              const LinearProgressIndicator(
                                minHeight: 2,
                              ),
                            ],

                            const SizedBox(height: 16),

                            // =================================================
                            // PHONE
                            // =================================================

                            SettingsField(
                              label: 'Phone Number',
                              controller:
                              _phoneController,
                            ),

                            const SizedBox(height: 16),

                            // =================================================
                            // JOB TITLE
                            // =================================================

                            SettingsField(
                              label:
                              'Headline / Job Title',
                              controller:
                              _jobTitleController,
                            ),

                            const SizedBox(height: 24),

                            // =================================================
                            // SAVE BUTTON
                            // =================================================

                            SizedBox(
                              width: double.infinity,
                              height: 44,

                              child: ElevatedButton(
                                onPressed: isSaving
                                    ? null
                                    : () {
                                  context
                                      .read<
                                      ProfileCubit>()
                                      .saveProfile(
                                    fullName:
                                    _fullNameController
                                        .text
                                        .trim(),
                                  );
                                },

                                style:
                                ElevatedButton.styleFrom(
                                  backgroundColor:
                                  AppColors.primary,
                                  foregroundColor:
                                  AppColors.white,
                                  elevation: 0,

                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      11,
                                    ),
                                  ),
                                ),

                                child: isSaving
                                    ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                  CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color:
                                    Colors.white,
                                  ),
                                )
                                    : Text(
                                  'Save Changes',
                                  style:
                                  GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}