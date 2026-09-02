import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';

/// Instructor rejection screen — shown when [ApprovalStatus.rejected].
///
/// Figma mapping (Account Not Approved — 390×873, bg #FFFFFF):
/// - 96px red badge (#BA1A1A) on soft #FFDAD6 halo
/// - Heading 32/600 #071E27, body 16/400 #3F4945
/// - Rejection card #DAF1FE with 4px left border #BA1A1A + shadow
/// - Help card #E7F6FF with mailto link + arrow
/// - Bottom "Sign Out" text link #0F5244
class AccountNotApprovedScreen extends StatelessWidget {
  const AccountNotApprovedScreen({super.key, this.rejectionReason});

  /// Optional server-provided reason; falls back to localized default.
  final String? rejectionReason;

  static const Color _error = Color(0xFFBA1A1A);
  static const Color _errorHalo = Color(0xFFFFDAD6);
  static const Color _rejectionCardBg = Color(0xFFDAF1FE);
  static const Color _helpCardBg = Color(0xFFE7F6FF);
  static const Color _titleColor = Color(0xFF071E27);
  static const Color _bodyColor = Color(0xFF3F4945);
  static const Color _helpTitleColor = Color(0xFF00342B);

  void _onContactSupport(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.support);
  }

  void _onSignOut(BuildContext context) {
    context.read<AuthCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    final String reason =
        (rejectionReason != null && rejectionReason!.trim().isNotEmpty)
        ? rejectionReason!.trim()
        : context.l10n.accountNotApprovedDefaultReason;

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
                  // Red badge (128 halo + 96 solid)
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
                          Icons.block_rounded,
                          size: 44,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // Headings
                  // =================================================
                  Text(
                    context.l10n.accountNotApprovedTitle,
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
                    context.l10n.accountNotApprovedSubtitle,
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
                  // Rejection reason card (#DAF1FE, left border #BA1A1A)
                  // =================================================
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _rejectionCardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 4,
                            decoration: const BoxDecoration(
                              color: _error,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(12),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                16,
                                16,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline_rounded,
                                        size: 20,
                                        color: _error,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        context
                                            .l10n
                                            .accountNotApprovedReasonLabel,
                                        style: const TextStyle(
                                          color: _error,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.1,
                                          height: 1.43,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    reason,
                                    style: const TextStyle(
                                      color: _titleColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // Help card (#E7F6FF)
                  // =================================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _helpCardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.help_outline_rounded,
                              size: 20,
                              color: _helpTitleColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              context.l10n.accountNotApprovedNeedHelp,
                              style: const TextStyle(
                                color: _titleColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.accountNotApprovedHelpBody,
                          style: const TextStyle(
                            color: _bodyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _onContactSupport(context),
                          borderRadius: BorderRadius.circular(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.supportEmail,
                                style: const TextStyle(
                                  color: _helpTitleColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  height: 1.33,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_outward_rounded,
                                size: 12,
                                color: _helpTitleColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // Sign Out (text link #0F5244, 20/600)
                  // =================================================
                  TextButton(
                    onPressed: () => _onSignOut(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      context.l10n.accountNotApprovedSignOut,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
