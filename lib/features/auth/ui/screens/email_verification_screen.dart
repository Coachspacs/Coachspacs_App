import 'dart:async';

import 'package:flutter/material.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/auth/ui/widgets/otp_code_row.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, this.email});

  final String? email;

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const int _initialResendSeconds = 59;

  final AuthRepository _authRepository = getIt<AuthRepository>();
  final OtpCodeRowController _otpController = OtpCodeRowController();
  int _remainingSeconds = _initialResendSeconds;
  Timer? _timer;
  bool _isResending = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
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

  Future<void> _resendCode() async {
    final email = widget.email;
    if (email == null || email.isEmpty || _isResending || _remainingSeconds > 0) {
      return;
    }

    setState(() => _isResending = true);
    try {
      await _authRepository.resendEmailVerification(email: email);
      if (!mounted) return;
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إعادة إرسال رمز التحقق')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر إعادة الإرسال: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  Future<void> _verifyCode() async {
    final email = widget.email;
    final code = _otpController.code;

    if (email == null || email.isEmpty) return;
    if (code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل رمز التحقق المكون من 6 أرقام')),
      );
      return;
    }

    setState(() => _isVerifying = true);
    try {
      await _authRepository.verifyOtp(email: email, code: code);
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.emailVerificationSuccess);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر التحقق: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailText = widget.email ?? 'mail@example.com';
    final canResend = widget.email != null && _remainingSeconds == 0 && !_isResending;

    return Scaffold(
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
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
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
                                  border: Border.all(color: AppColors.white, width: 2),
                                ),
                                child: const Icon(Icons.check, color: AppColors.white, size: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'تحقق من بريدك الإلكتروني',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                              const TextSpan(text: 'لقد أرسلنا رمز التحقق إلى '),
                              TextSpan(
                                text: emailText,
                                style: const TextStyle(
                                  color: AppColors.textBody,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(text: '. يرجى إدخال الرمز المكون من 6 أرقام للمتابعة.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        OtpCodeRow(controller: _otpController),
                        const SizedBox(height: 24),
                        MyButton(
                          text: _isVerifying ? 'جاري التحقق...' : 'تحقق الآن',
                          onPressed: _isVerifying ? () {} : _verifyCode,
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
                            const Text(
                              'لم يصلك الرمز؟',
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: canResend ? _resendCode : null,
                              child: Text(
                                _isResending
                                    ? 'جاري الإرسال...'
                                    : 'إعادة الإرسال (${_remainingSeconds ~/ 60}:${(_remainingSeconds % 60).toString().padLeft(2, '0')})',
                                style: TextStyle(
                                  color: canResend ? AppColors.primary : AppColors.textLight,
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
    );
  }
}
