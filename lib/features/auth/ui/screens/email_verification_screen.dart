import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

/// Confirmation shown immediately after a verification email is sent again.
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, this.email});
  final String? email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const _initialSeconds = 60;
  Timer? _timer;
  var _remainingSeconds = _initialSeconds;
  var _resending = false;

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
    setState(() => _remainingSeconds = _initialSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _remainingSeconds == 0) {
        timer.cancel();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  void _resend() {
    if (_remainingSeconds > 0 || _resending || widget.email == null) return;
    setState(() => _resending = true);
    context.read<AuthCubit>().resendVerification(widget.email!);
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state is AuthResendSuccess) {
        setState(() => _resending = false);
        _startTimer();
      } else if (state is AuthResendFailure) {
        setState(() => _resending = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message)));
      }
    },
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 42),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC5DFEA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.forward_to_inbox_rounded,
                      size: 52,
                      color: Color(0xFF003F35),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    context.l10n.emailVerificationTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF003F35),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.emailVerificationBodyPrefix +
                        context.l10n.emailVerificationBodySuffix,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF3F4945),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10n.emailVerificationOpenEmailHint,
                              ),
                            ),
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: const Color(0x66006B5C),
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        context.l10n.emailVerificationOpenEmail,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    context.l10n.emailVerificationNotReceived,
                    style: const TextStyle(
                      color: Color(0xFF3F4945),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _remainingSeconds == 0 ? _resend : null,
                    child: Text(
                      _resending
                          ? context.l10n.emailVerificationSending
                          : _remainingSeconds == 0
                          ? context.l10n.emailVerificationResendCountdown('')
                          : context.l10n.emailVerificationResendCountdown(
                              '$_remainingSeconds',
                            ),
                      style: TextStyle(
                        color: _remainingSeconds == 0
                            ? AppColors.primary
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
