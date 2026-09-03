import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';

/// Shown to instructors whose account is awaiting admin approval.
///
/// Figma: Account Under Review — 390×873, bg #FFFFFF/F4FAFF
/// halo 192 rgba(0,52,43,0.05) blur, badge 128 #D5ECF8 + shadow,
/// check badge 48 #D1FAE5, title 32/600 #071E27, body 16/400 #3F4945,
/// CTA #0F5244 30px + shadow, text link #0F5244 20/600.
class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  static const Color _titleColor = Color(0xFF071E27);
  static const Color _bodyColor = Color(0xFF3F4945);
  static const Color _badgeBg = Color(0xFFD5ECF8);
  static const Color _checkBg = Color(0xFFD1FAE5);
  static const Color _halo = Color(0x0D00342B);

  void _onContactSupport(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.support);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Badge — 192 halo + 128 solid + 48 check
                  // =================================================
                  SizedBox(
                    width: 192,
                    height: 192,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 192,
                          height: 192,
                          decoration: const BoxDecoration(
                            color: _halo,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 128,
                          height: 128,
                          decoration: const BoxDecoration(
                            color: _badgeBg,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A00342B),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                              BoxShadow(
                                color: Color(0x0F00342B),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.hourglass_bottom_rounded,
                            size: 58,
                            color: Color(0xFF00342B),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _checkBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.white,
                                width: 4,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              size: 28,
                              color: Color(0xFF00342B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // Title
                  // =================================================
                  Text(
                    context.l10n.accountUnderReviewTitle,
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
                    context.l10n.accountUnderReviewSubtitle,
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
                  // Primary — Contact Support (#0F5244, 30px)
                  // =================================================
                  DecoratedBox(
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
                      text: context.l10n.accountUnderReviewContactSupport,
                      onPressed: () => _onContactSupport(context),
                      color: AppColors.primary,
                      textColor: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      borderRadius: 30,
                      width: double.infinity,
                      height: 56,
                      padding: EdgeInsets.zero,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // Secondary — Sign Out (text link #0F5244)
                  // =================================================
                  TextButton(
                    onPressed: () => context.read<AuthCubit>().logout(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      context.l10n.pendingApprovalLogout,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
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
}
