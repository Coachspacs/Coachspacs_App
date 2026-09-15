import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class AccountSettingsHeader extends StatelessWidget {
  const AccountSettingsHeader({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        14,
        10,
        16,
        6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // =====================================================
          // BACK BUTTON
          // =====================================================

          IconButton(
            onPressed: onBack ?? () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: AppColors.textBody,
            ),
          ),

          const SizedBox(width: 6),

          // =====================================================
          // TITLE
          // =====================================================

          Expanded(
            child: Text(
              'Student Settings',
              style: GoogleFonts.inter(
                color: AppColors.textBody,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}