import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bold section heading inside the checkout form.
class CheckoutSectionTitle extends StatelessWidget {
  const CheckoutSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }
}
