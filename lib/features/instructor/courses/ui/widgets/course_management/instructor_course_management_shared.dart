import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorManagementSectionCard extends StatelessWidget {
  const InstructorManagementSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF173D37),
                ),
              ),

              const Spacer(),

              if (trailing != null)
                Text(
                  trailing!,
                  style: GoogleFonts.inter(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF075E4D),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 13),

          child,
        ],
      ),
    );
  }
}

// =============================================================
// MANAGEMENT STAT CARD
// =============================================================

class InstructorManagementStatCard extends StatelessWidget {
  const InstructorManagementStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE2F4EE),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 17,
              color: const Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 7.5,
                    color: const Color(0xFF7B8985),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// OVERVIEW ROW
// =============================================================

class InstructorOverviewRow extends StatelessWidget {
  const InstructorOverviewRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 11,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF075E4D),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: const Color(0xFF687772),
              ),
            ),
          ),

          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF263C38),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// CONTENT SECTION
// =============================================================

class InstructorContentSection extends StatelessWidget {
  const InstructorContentSection({
    super.key,
    required this.number,
    required this.title,
    required this.lessons,
    required this.showDivider,
  });

  final String number;
  final String title;
  final String lessons;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: Color(0xFFE8EFED),
          ),
        )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F4F0),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: GoogleFonts.inter(
                fontSize: 7,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF263C38),
              ),
            ),
          ),

          Text(
            lessons,
            style: GoogleFonts.inter(
              fontSize: 7.5,
              color: const Color(0xFF7B8985),
            ),
          ),

          const SizedBox(width: 5),

          const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: Color(0xFF8A9692),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// STUDENT ROW
// =============================================================

class InstructorStudentManagementRow extends StatelessWidget {
  const InstructorStudentManagementRow({
    super.key,
    required this.name,
    required this.progress,
    required this.enrolled,
    required this.showDivider,
  });

  final String name;
  final String progress;
  final String enrolled;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: Color(0xFFE8EFED),
          ),
        )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFDDF3EB),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              name.substring(0, 1),
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Enrolled $enrolled',
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    color: const Color(0xFF899590),
                  ),
                ),
              ],
            ),
          ),

          Text(
            progress,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF075E4D),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// SETTING ROW
// =============================================================

class InstructorSettingRow extends StatelessWidget {
  const InstructorSettingRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8EFED),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xFF075E4D),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: const Color(0xFF687772),
              ),
            ),
          ),

          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF263C38),
            ),
          ),
        ],
      ),
    );
  }
}