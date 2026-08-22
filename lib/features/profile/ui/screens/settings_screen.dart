import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  const SettingsScreen({super.key});

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
    } else if (state is ProfileSaveSuccess || state is ProfileAvatarSuccess) {
      // Keep controllers in sync after a successful mutation.
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
      SnackBar(content: Text(message)),
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
    await context.read<ProfileCubit>().uploadAvatar(File(picked.path));
  }

  Future<void> _showChangeEmailDialog() async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final l10n = context.l10n;
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.settingsChangeEmailTitle),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.settingsNewEmailLabel,
                hintText: 'name@example.com',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter your new email';
                }
                if (!value.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.settingsCancel),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pop(dialogContext, controller.text.trim());
                }
              },
              child: Text(l10n.settingsSend),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (result == null || result.isEmpty) return;
    if (!mounted) return;
    await context.read<ProfileCubit>().requestEmailChange(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        _seedFromProfile(state);
        switch (state) {
          case ProfileSaveSuccess():
            _showSnack(context.l10n.settingsSaveSuccess);
          case ProfileSaveFailure(:final message):
            _showSnack(message);
          case ProfileAvatarSuccess():
            _showSnack(context.l10n.settingsAvatarUpdated);
            setState(() {});
          case ProfileAvatarFailure(:final message):
            _showSnack(message);
          case ProfileEmailChangeSuccess():
            _showSnack(context.l10n.settingsEmailChangeSent);
          case ProfileEmailChangeFailure(:final message):
            _showSnack(message);
          case ProfileEmailConfirmSuccess():
            _showSnack(context.l10n.settingsSaveSuccess);
          case ProfileEmailConfirmFailure(:final message):
            _showSnack(message);
          case ProfileLoadFailure(:final message):
            _showSnack(message);
          default:
            break;
        }
      },
      builder: (context, state) {
        final isInitialLoading = state is ProfileLoading && !_didSeed;
        final isSaving = state is ProfileSaving;
        final isAvatarUploading = state is ProfileAvatarUploading;
        final isEmailChanging = state is ProfileEmailChangeLoading;

        if (isInitialLoading) {
          return Scaffold(
            backgroundColor: AppColors.bgDefault,
            body: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SettingsHeader(),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SettingsTabs(),
                  ),
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: null,
                      child: Text(''),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

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
                      const Icon(Icons.error_outline, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () =>
                            context.read<ProfileCubit>().loadProfile(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.bgDefault,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsHeader(),
                      const SizedBox(height: 20),
                      const SettingsTabs(),
                      const SizedBox(height: 20),
                      AvatarSection(
                        imageUrl: _avatarUrl,
                        isUploading: isAvatarUploading,
                        onTap: _pickAndUploadAvatar,
                      ),
                      const SizedBox(height: 24),
                      SettingsField(
                        label: 'Full Name',
                        controller: _fullNameController,
                      ),
                      const SizedBox(height: 16),
                      SettingsField(
                        label: 'Email Address',
                        controller: _emailController,
                        showChange: true,
                        onChangeTap: isEmailChanging
                            ? null
                            : _showChangeEmailDialog,
                      ),
                      if (isEmailChanging) ...[
                        const SizedBox(height: 8),
                        const LinearProgressIndicator(),
                      ],
                      const SizedBox(height: 16),
                      SettingsField(
                        label: 'Phone Number',
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 16),
                      SettingsField(
                        label: 'Headline / Job Title',
                        controller: _jobTitleController,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isSaving
                              ? null
                              : () {
                                  context.read<ProfileCubit>().saveProfile(
                                        fullName: _fullNameController.text,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B624F),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
