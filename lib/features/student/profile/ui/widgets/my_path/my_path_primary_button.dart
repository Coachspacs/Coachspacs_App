import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_path_palette.dart';

/// Primary full-width CTA used across the My Path wizard.
class MyPathPrimaryButton extends StatelessWidget {
  const MyPathPrimaryButton({
    super.key,
    required this.label,
    this.subtitle,
    this.onPressed,
  });

  final String label;
  final String? subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyPathColors.cta,
              disabledBackgroundColor: MyPathColors.cta.withValues(alpha: .45),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_rounded, size: 21),
              ],
            ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF71817E),
            ),
          ),
        ],
      ],
    );
  }
}
