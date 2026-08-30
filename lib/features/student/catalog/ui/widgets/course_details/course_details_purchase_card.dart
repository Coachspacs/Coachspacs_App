import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

import '../../../../notifications/data/models/notification.dart';
import '../../../../notifications/logic/notification_service.dart';

class CourseDetailsPurchaseCard extends StatelessWidget {
  const CourseDetailsPurchaseCard({
    super.key,
    required this.price,
    required this.courseTitle,
  });

  final String price;
  final String courseTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================================================
          // PRICE
          // =========================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 9),

              Text(
                '\$119.00',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // =========================================================
          // ADD TO CART
          // =========================================================

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                // Guest cannot add courses to cart
                if (GuestSession.isGuest) {
                  LoginRequiredDialog.show(context);
                  return;
                }

                _showAddToCartDialog(context);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 18,
              ),
              label: Text(
                'Add to Cart',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),

          const SizedBox(height: 9),

          // =========================================================
          // BUY NOW
          // =========================================================

          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {
                // Guest cannot buy courses
                if (GuestSession.isGuest) {
                  LoginRequiredDialog.show(context);
                  return;
                }

                // =================================================
                // BUY NOW ACTION
                // =================================================
                //
                // Add the real purchase logic here later.
                //
                // For now, the important part is that guests
                // cannot continue with the purchase.
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF075E4D),
                side: const BorderSide(
                  color: Color(0xFF075E4D),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: Text(
                'Buy Now',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // =========================================================
          // GUARANTEE
          // =========================================================

          Center(
            child: Text(
              '30-Day Money-Back Guarantee',
              style: GoogleFonts.inter(
                fontSize: 8.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF899792),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // ADD TO CART CONFIRMATION
  // ===============================================================

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              22,
              20,
              18,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =================================================
                // CART ICON
                // =================================================

                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5F5F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFF075E4D),
                    size: 25,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Add to Cart?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Would you like to add this course '
                      'to your cart?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.45,
                    color: const Color(0xFF71807C),
                  ),
                ),

                const SizedBox(height: 20),

                // =================================================
                // BUTTONS
                // =================================================

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                            const Color(0xFF52615D),
                            side: const BorderSide(
                              color: Color(0xFFD5E1DE),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);

                            // ==========================================
                            // ADD NOTIFICATION
                            // ==========================================

                            NotificationService.instance
                                .addNotification(
                              title: 'Course Added to Cart',
                              message:
                              '$courseTitle has been added '
                                  'to your cart successfully.',
                              time: 'Just now',
                              type: NotificationType.purchase,
                            );

                            _showSuccessDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF075E4D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11),
                            ),
                          ),
                          child: Text(
                            'Yes, Add it',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===============================================================
  // SUCCESS DIALOG
  // ===============================================================

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              24,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =================================================
                // SUCCESS ICON
                // =================================================

                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F5ED),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Color(0xFF075E4D),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'Added Successfully!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'The course has been added '
                      'to your cart successfully.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.45,
                    color: const Color(0xFF71807C),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(11),
                      ),
                    ),
                    child: Text(
                      'Done',
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
      },
    );
  }
}