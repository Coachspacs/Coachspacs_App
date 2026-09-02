import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorProfileSection
    extends StatelessWidget {
  const InstructorProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFDDE8E5),
            ),
          ),
          child: Column(
            children: _withDividers(children),
          ),
        ),
      ],
    );
  }

  List<Widget> _withDividers(
      List<Widget> items,
      ) {
    final result = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      result.add(items[i]);

      if (i < items.length - 1) {
        result.add(
          const Divider(
            height: 1,
            indent: 56,
            endIndent: 14,
            color: Color(0xFFEAF0EE),
          ),
        );
      }
    }

    return result;
  }
}