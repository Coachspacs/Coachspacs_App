import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

/// Email-verification screen aligned with the backend contract.
///
/// The backend does **not** send a numeric OTP: it emails a verification
/// *link* (`GET /api/auth/verify-email?uid=...&token=...`). This screen tells
/// the user to click that link and lets them resend it. Verification itself is
/// completed by the link (opened outside the app) — no code entry is needed.
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, this.email});

  final String? email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const int _initialResendSeconds = 59;

  int _remainingSeconds = _initialResendSeconds;
  Timer? _timer;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = _initialResendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds == 0) {
        timer.cancel();
        setState(() {});
        return;
      }
      setState(() {
        _remainingSeconds--;
      });
    });
  }

  String get _resendLabel {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _resendLink() {
    final email = widget.email;
    if (email == null || email.isEmpty || _remainingSeconds > 0) return;
    setState(() => _isResending = true);
    context.read<AuthCubit>().resendVerification(email);
  }

  @override
  Widget build(BuildContext context) {
    final emailText = widget.email ?? 'mail@example.com';
    final canResend =
        widget.email != null && _remainingSeconds == 0 && !_isResending;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthResendSuccess():
            _startTimer();
            setState(() => _isResending = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.emailVerificationResent)),
            );
            break;
          case AuthResendFailure(:final message):
            setState(() => _isResending = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5FBF9),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -40,
                right: -40,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0x3388D8C9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0x3399E7DD),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.5),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14006B68),
                            blurRadius: 18,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                              color: AppColors.textLight,
                            ),
                          ),
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC1EBE7),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.mark_email_read,
                                    size: 48,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.l10n.emailVerificationTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                color: AppColors.textLight,
                                fontSize: 16,
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      context.l10n.emailVerificationBodyPrefix,
                                ),
                                TextSpan(
                                  text: emailText,
                                  style: const TextStyle(
                                    color: AppColors.textBody,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      context.l10n.emailVerificationBodySuffix,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          MyButton(
                            text: context.l10n.emailVerificationOpenEmail,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.l10n.emailVerificationOpenEmailHint,
                                  ),
                                ),
                              );
                            },
                            color: AppColors.primary,
                            textColor: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            borderRadius: 12,
                            width: double.infinity,
                            height: 54,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              Text(
                                context.l10n.emailVerificationNotReceived,
                                style: const TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: canResend ? _resendLink : null,
                                child: Text(
                                  _isResending
                                      ? context.l10n.emailVerificationSending
                                      : context.l10n
                                            .emailVerificationResendCountdown(
                                              _resendLabel,
                                            ),
                                  style: TextStyle(
                                    color: canResend
                                        ? AppColors.primary
                                        : AppColors.textLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
