import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPathHeader extends StatelessWidget {
  const MyPathHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 23,
              color: Color(0xFF172B2A),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),

          const SizedBox(width: 4),
          Text(
            'My Path',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF075E4D),
            ),
          ),
        ],
      ),
    );
  }
}
