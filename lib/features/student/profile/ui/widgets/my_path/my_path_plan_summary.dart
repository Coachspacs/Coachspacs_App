import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/my_path_models.dart';
import 'my_path_palette.dart';

/// Summary of the selections made so far in the My Path wizard.
class MyPathPlanSummary extends StatelessWidget {
  const MyPathPlanSummary({
    super.key,
    required this.goal,
    required this.level,
    required this.skill,
    required this.hours,
    required this.completed,
  });

  final MyPathOption? goal;
  final MyPathOption? level;
  final MyPathSkillOption? skill;
  final MyPathOption? hours;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final rows = <_RowData>[
      _RowData(
        Icons.flag_outlined,
        'Goal',
        goal?.title,
      ),
      _RowData(
        Icons.stairs_outlined,
        'Level',
        level?.title,
      ),
      _RowData(
        Icons.interests_outlined,
        'Skill',
        skill?.title,
      ),
      _RowData(
        Icons.schedule_outlined,
        'Schedule',
        hours?.title,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: completed ? MyPathColors.primary : MyPathColors.cardBorder,
          width: completed ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                completed ? Icons.verified_rounded : Icons.pending_actions_outlined,
                size: 16,
                color: completed ? MyPathColors.primary : MyPathColors.amber,
              ),
              const SizedBox(width: 6),
              Text(
                completed ? 'Your Active Plan' : 'Your Plan So Far',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: MyPathColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (completed)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: MyPathColors.selectedFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Ready',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: MyPathColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _SummaryRow(data: row),
            ),
        ],
      ),
    );
  }
}

class _RowData {
  const _RowData(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String? value;
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.data});

  final _RowData data;

  @override
  Widget build(BuildContext context) {
    final hasValue = data.value != null;
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hasValue
                ? MyPathColors.selectedFill
                : const Color(0xFFF2F6F7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            data.icon,
            size: 14,
            color: hasValue
                ? MyPathColors.primary
                : const Color(0xFF9DAEB2),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          data.label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF71817E),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            data.value ?? 'Not set yet',
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400,
              color: hasValue
                  ? MyPathColors.textPrimary
                  : const Color(0xFF9DAEB2),
            ),
          ),
        ),
      ],
    );
  }
}
