import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

/// Verification link expired — distinct from the "check your email" pending
/// state. Offer to resend the verification link or go back to login.
///
/// Figma-style mapping (error variant of Email Verified):
/// - Halo #FFDAD6 + solid #BA1A1A badge with link_off icon
/// - Title 32/600 #071E27, body 16/400 #3F4945
/// - Primary #0F5244 30px, secondary text #0F5244
class LinkExpiredScreen extends StatefulWidget {
  const LinkExpiredScreen({
    super.key,
    this.email,
  });

  final String? email;

  @override
  State<LinkExpiredScreen> createState() => _LinkExpiredScreenState();
}

class _LinkExpiredScreenState extends State<LinkExpiredScreen> {
  bool _resending = false;

  static const Color _error = Color(0xFFBA1A1A);
  static const Color _errorHalo = Color(0xFFFFDAD6);
  static const Color _titleColor = Color(0xFF071E27);
  static const Color _bodyColor = Color(0xFF3F4945);

  void _resend() {
    final String? email = widget.email;
    if (email == null || email.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.linkExpiredNoEmail)),
      );
      return;
    }
    setState(() => _resending = true);
    context.read<AuthCubit>().resendVerification(email.trim());
  }

  void _goToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthResendSuccess():
            setState(() => _resending = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.emailVerificationResent)),
            );
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.emailVerification,
              arguments: widget.email,
            );
            break;
          case AuthResendFailure(:final message):
            setState(() => _resending = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 390),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // =================================================
                    // Badge — halo 128 + solid 96 (error)
                    // =================================================
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            color: _errorHalo.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 96,
                          height: 96,
                          decoration: const BoxDecoration(
                            color: _error,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.link_off_rounded,
                            size: 40,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // =================================================
                    // Titles
                    // =================================================
                    Text(
                      context.l10n.linkExpiredTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _titleColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      context.l10n.linkExpiredSubtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _bodyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // Primary — Resend link
                    // =================================================
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) =>
                          previous is AuthResendLoading ||
                          current is AuthResendLoading,
                      builder: (context, state) {
                        final bool loading =
                            state is AuthResendLoading || _resending;
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33006B5C),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                              BoxShadow(
                                color: Color(0x33006B5C),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: MyButton(
                            text: loading
                                ? context.l10n.emailVerificationSending
                                : context.l10n.linkExpiredResendButton,
                            onPressed: loading ? () {} : _resend,
                            color: AppColors.primary,
                            textColor: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            borderRadius: 30,
                            width: double.infinity,
                            height: 56,
                            padding: EdgeInsets.zero,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // Secondary — Back to login
                    // =================================================
                    TextButton(
                      onPressed: _goToLogin,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        context.l10n.linkExpiredBackToLogin,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),

                    if (widget.email != null && widget.email!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.email!,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          color: _bodyColor,
                          fontSize: 12,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
