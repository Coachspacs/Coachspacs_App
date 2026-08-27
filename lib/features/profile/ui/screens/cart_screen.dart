import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/cart/cart_item.dart';
import 'package:coach_space/features/profile/ui/widgets/cart/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double coursePrice = 89.00;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                10,
                16,
                0,
              ),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 34,
                      minHeight: 34,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 23,
                      color: Color(0xFF073F38),
                    ),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    'My Cart',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------
                    // ITEM COUNT
                    // ------------------------------------------------

                    Text(
                      '1 item',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF71827E),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ------------------------------------------------
                    // CART ITEM
                    // ------------------------------------------------

                    CartItem(
                      title:
                      'Next.js 15 & React 19 Fullstack Masterclass',
                      instructor: 'Dr. Tareq Al-Mansoor',
                      price: coursePrice,
                      onDelete: () {
                        _showRemoveDialog(context);
                      },
                    ),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // ORDER SUMMARY
                    // ------------------------------------------------

                    CartSummary(
                      subtotal: coursePrice,
                      onCheckout: () {
                        _showCheckoutDialog(context);
                      },
                    ),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // PAYMENT / GUARANTEE INFO
                    // ------------------------------------------------

                    _buildBenefits(),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // BENEFITS
  // ===============================================================

  Widget _buildBenefits() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Row(
        children: const [
          Expanded(
            child: _BenefitItem(
              icon: Icons.verified_user_outlined,
              title: 'Secure',
              subtitle: 'Payment',
            ),
          ),

          _BenefitDivider(),

          Expanded(
            child: _BenefitItem(
              icon: Icons.replay_rounded,
              title: '30-Day',
              subtitle: 'Guarantee',
            ),
          ),

          _BenefitDivider(),

          Expanded(
            child: _BenefitItem(
              icon: Icons.support_agent_outlined,
              title: '24/7',
              subtitle: 'Support',
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // REMOVE DIALOG
  // ===============================================================

  void _showRemoveDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Remove Course?',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          content: Text(
            'Are you sure you want to remove this course from your cart?',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF687772),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Course removed from cart',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF075E4D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: Text(
                'Remove',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ===============================================================
  // CHECKOUT DIALOG
  // ===============================================================

  void _showCheckoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Ready to Checkout?',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          content: Text(
            'You are about to continue with your purchase.',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF687772),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF687772),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Checkout started successfully',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF075E4D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===================================================================
// BENEFIT ITEM
// ===================================================================

class _BenefitItem extends StatelessWidget {
  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFE4F6F0),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 19,
            color: const Color(0xFF075E4D),
          ),
        ),

        const SizedBox(height: 7),

        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF075E4D),
          ),
        ),

        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: const Color(0xFF687772),
          ),
        ),
      ],
    );
  }
}

// ===================================================================
// BENEFIT DIVIDER
// ===================================================================

class _BenefitDivider extends StatelessWidget {
  const _BenefitDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: const Color(0xFFE1E9E6),
    );
  }
}