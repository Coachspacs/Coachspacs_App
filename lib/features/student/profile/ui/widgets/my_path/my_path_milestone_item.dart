import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPathMilestoneItem extends StatelessWidget {
  const MyPathMilestoneItem({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    this.isDone = false,
    this.isActive = false,
    this.isLast = false,
    this.isFinalGoal = false,
    this.actionLabel,
  });

  final int number;
  final String title;
  final String description;
  final bool isDone;
  final bool isActive;
  final bool isLast;
  final bool isFinalGoal;
  final String? actionLabel;

  static const Color primary = Color(0xFF075E4D);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =======================================================
        // NUMBER + CONNECTOR
        // =======================================================

        SizedBox(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDone || isActive
                      ? primary
                      : const Color(0xFFF2F6F7),
                  shape: BoxShape.circle,
                  border: isDone || isActive
                      ? null
                      : Border.all(
                    color: const Color(0xFFC9D9DE),
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check_rounded,
                        size: 16, color: Colors.white)
                    : Text(
                  '$number',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF60727A),
                  ),
                ),
              ),

              if (!isLast)
                Container(
                  width: 2,
                  height: 48,
                  color: isDone
                      ? primary.withValues(alpha: .45)
                      : const Color(0xFFDCE5E7),
                ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // =======================================================
        // CONTENT
        // =======================================================

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 1,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF263A3A),
                        ),
                      ),
                    ),

                    if (actionLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1FBF7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFBFE7D8),
                          ),
                        ),
                        child: Text(
                          actionLabel!,
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ),

                    if (isFinalGoal)
                      Text(
                        '★ Final Goal',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFD67B00),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.55,
                    color: const Color(0xFF687B80),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}