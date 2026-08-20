import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/signup/presentation/widgets/signup_bottom_waves_painter.dart';

/// Shown to instructors whose account is awaiting admin approval.
///
/// They have no dashboard access yet — the only way forward is to log out.
/// (Re-login keeps returning this screen until an admin approves the account.)
class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC1EBE7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.hourglass_top,
                          size: 56,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        context.l10n.pendingApprovalTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textBody,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.l10n.pendingApprovalSubtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textLight,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: MyButton(
                text: context.l10n.pendingApprovalLogout,
                onPressed: () => context.read<AuthCubit>().logout(),
                color: AppColors.primary,
                textColor: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                borderRadius: 12,
                width: double.infinity,
                height: 54,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 110,
              child: CustomPaint(painter: SignupBottomWavesPainter()),
            ),
          ],
        ),
      ),
    );
  }
}
