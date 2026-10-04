import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

/// Empty-checkout state with a "go back" action.
class CheckoutEmptyView extends StatelessWidget {
  const CheckoutEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: Color(0xFFE4F6F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.remove_shopping_cart_outlined,
                size: 26,
                color: Color(0xFF075E4D),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.checkoutNoItems,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.checkoutNoItemsHint,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text(
                  l10n.checkoutGoBack,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
