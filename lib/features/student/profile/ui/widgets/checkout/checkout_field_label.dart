import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Small bold label rendered above a checkout form field.
class CheckoutFieldLabel extends StatelessWidget {
  const CheckoutFieldLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF073F38),
      ),
    );
  }
}
