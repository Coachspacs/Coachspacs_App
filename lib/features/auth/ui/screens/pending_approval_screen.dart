import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/buttons.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),
      body: SafeArea(
        child: Stack(
          children: [
            // Soft decorative circle
            Positioned(
              top: -80,
              right: -70,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0x3388D8C9),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Soft decorative circle
            Positioned(
              bottom: -80,
              left: -70,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0x22BEC9C7),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Pending icon
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFDDEBE6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.hourglass_top_rounded,
                          size: 54,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Title
                      Text(
                        context.l10n.pendingApprovalTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF073F38),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        context.l10n.pendingApprovalSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          height: 1.7,
                          color: const Color(0xFF7C8A86),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Logout button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MyButton(
                          text: context.l10n.pendingApprovalLogout,
                          onPressed: () =>
                              context.read<AuthCubit>().logout(),
                          color: AppColors.primary,
                          textColor: AppColors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          borderRadius: 26,
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
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