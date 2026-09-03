import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';

class EmailVerificationSuccessScreen extends StatelessWidget {
  const EmailVerificationSuccessScreen({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final destination = role == UserRole.instructor
        ? AppRoutes.instructorDashboard
        : AppRoutes.home;
    return _VerificationResultPage(
      iconBackground: const Color(0xFFA7EBD9),
      iconColor: const Color(0xFF003F35),
      icon: Icons.check_rounded,
      title: context.l10n.emailVerifiedSuccessTitle,
      body: context.l10n.emailVerifiedSuccessBody,
      buttonLabel: context.l10n.emailVerifiedContinue,
      showArrow: true,
      onPressed: () =>
          Navigator.pushNamedAndRemoveUntil(context, destination, (_) => false),
    );
  }
}

class VerificationAlreadyCompleteScreen extends StatelessWidget {
  const VerificationAlreadyCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) => _VerificationResultPage(
    iconBackground: const Color(0xFF005746),
    iconColor: const Color(0xFF91D7C6),
    icon: Icons.check_rounded,
    title: context.l10n.emailAlreadyVerifiedTitle,
    body: context.l10n.emailAlreadyVerifiedBody,
    buttonLabel: context.l10n.emailAlreadyVerifiedSignIn,
    onPressed: () => Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (_) => false,
    ),
  );
}

class _VerificationResultPage extends StatelessWidget {
  const _VerificationResultPage({
    required this.iconBackground,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.onPressed,
    this.showArrow = false,
  });

  final Color iconBackground;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String body;
  final String buttonLabel;
  final VoidCallback onPressed;
  final bool showArrow;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconBackground, size: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF071E27),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  body,
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
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0x66006B5C),
                      shape: const StadiumBorder(),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (showArrow)
                          const PositionedDirectional(
                            end: 10,
                            child: Icon(Icons.arrow_forward_rounded, size: 30),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
