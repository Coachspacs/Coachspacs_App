import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/snackbar_helper.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';

/// "Ready for payment" confirmation shown after a successful checkout.
class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({
    super.key,
    required this.session,
  });

  final CheckoutSessionDto session;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasUrl = session.hasCheckoutUrl;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 40, 26, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF3D6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.payments_outlined,
                color: Color(0xFFB7791F),
                size: 34,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.checkoutReadyForPayment,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF073F38),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasUrl
                  ? l10n.checkoutReadyForPaymentHint
                  : l10n.checkoutProcessing,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                height: 1.5,
                color: const Color(0xFF71807C),
              ),
            ),
            if (session.orderId > 0) ...[
              const SizedBox(height: 8),
              Text(
                '${l10n.checkoutOrderNumber} ${session.orderId}',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF073F38),
                ),
              ),
            ],
            const SizedBox(height: 22),
            if (hasUrl)
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () => _openCheckoutUrl(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.checkoutContinuePayment,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            if (hasUrl) const SizedBox(height: 9),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.orderHistory,
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF075E4D),
                  side: const BorderSide(color: Color(0xFFBFE9D8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.checkoutViewOrders,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCheckoutUrl(BuildContext context) async {
    final uri = Uri.tryParse(session.checkoutUrl);
    final launched = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      showAppSnackBar(
        context,
        context.l10n.checkoutPaymentOpenFailed,
        isError: true,
      );
    }
  }
}
