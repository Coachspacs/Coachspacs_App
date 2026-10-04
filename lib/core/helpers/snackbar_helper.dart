import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shows a floating, rounded [SnackBar] with consistent typography.
///
/// Set [isError] to use the destructive background color.
void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 12),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            isError ? const Color(0xFFD9363E) : const Color(0xFF075E4D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
}
