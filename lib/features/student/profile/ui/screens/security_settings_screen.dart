import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/logic/cubit/security_cubit.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<SecurityCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final current = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    String? error;
    if (current.isEmpty) {
      error = l10n.securityCurrentRequired;
    } else if (newPassword.isEmpty) {
      error = l10n.securityNewRequired;
    } else if (confirm.isEmpty) {
      error = l10n.securityConfirmRequired;
    } else if (newPassword.length < 8) {
      error = l10n.securityTooShort;
    } else if (newPassword != confirm) {
      error = l10n.securityPasswordsNoMatch;
    }

    if (error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error, style: GoogleFonts.inter(fontSize: 11)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final success = await cubit.changePassword(
      currentPassword: current,
      newPassword: newPassword,
    );

    if (!context.mounted) return;

    final state = cubit.state;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success
              ? l10n.securityPasswordChanged
              : localizedFailureMessage(
                  context,
                  state is SecurityFailure ? state.kind : FailureKind.unknown,
                  state is SecurityFailure ? state.message : '',
                ),
          style: GoogleFonts.inter(fontSize: 11),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (success) {
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SecurityCubit>(
      create: (_) => getIt<SecurityCubit>(),
      child: Builder(
        builder: (context) {
          final isSaving = context.select(
            (SecurityCubit cubit) => cubit.state is SecuritySaving,
          );

          return Scaffold(
            backgroundColor: AppColors.bgDefault,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 25,
                            color: Color(0xFF073F38),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.securityTitle,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF073F38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFDCE7E4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _PasswordField(
                                  label: context.l10n.securityCurrentPassword,
                                  controller: _currentPasswordController,
                                  obscureText: _obscureCurrent,
                                  onToggle: () => setState(
                                    () => _obscureCurrent = !_obscureCurrent,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _PasswordField(
                                  label: context.l10n.securityNewPassword,
                                  controller: _newPasswordController,
                                  obscureText: _obscureNew,
                                  onToggle: () => setState(
                                    () => _obscureNew = !_obscureNew,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _PasswordField(
                                  label: context.l10n.securityConfirmPassword,
                                  controller: _confirmPasswordController,
                                  obscureText: _obscureConfirm,
                                  onToggle: () => setState(
                                    () => _obscureConfirm = !_obscureConfirm,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 42),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: isSaving
                                  ? null
                                  : () => _saveChanges(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
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
                                      context.l10n.securitySaveChanges,
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
        },
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF073F38),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF344842),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 19,
                  color: const Color(0xFF71807C),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
