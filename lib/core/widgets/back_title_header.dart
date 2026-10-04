import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Simple screen header: a back button followed by a bold title.
///
/// Used by cart, order history, checkout, security settings and other
/// detail screens that sit on top of the navigation stack.
class BackTitleHeader extends StatelessWidget {
  const BackTitleHeader({
    super.key,
    required this.title,
    this.titleFontSize = 22,
    this.padding = const EdgeInsets.fromLTRB(12, 10, 16, 0),
  });

  final String title;
  final double titleFontSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
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
            title,
            style: GoogleFonts.inter(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}
