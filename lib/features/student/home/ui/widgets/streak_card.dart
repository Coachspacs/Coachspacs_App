import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF075E4D);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F8F2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFC7EEE2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0D8),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: Color(0xFFF29B38),
                  size: 21,
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3-Day Streak!',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF4D5968),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Personal best: 7 days',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: const Color(0xFF7B8584),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: green,
                    width: 6,
                  ),
                ),
                child: Center(
                  child: Text(
                    '80%',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: green,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: const [
              _DayItem(
                day: 'M',
                completed: true,
              ),
              _DayItem(
                day: 'T',
                completed: true,
              ),
              _DayItem(
                day: 'W',
                completed: true,
              ),
              _DayItem(
                day: 'T',
                completed: true,
                selected: true,
              ),
              _DayItem(day: 'F'),
              _DayItem(day: 'S'),
              _DayItem(day: 'S'),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 14,
                color: Color(0xFF64726E),
              ),

              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  'Keep it going! Complete 1 lesson today to secure Day 4',
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    height: 1.3,
                    color: const Color(0xFF4E5C59),
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC7EEE2),
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: Text(
                  '+10 XP',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.day,
    this.completed = false,
    this.selected = false,
  });

  final String day;
  final bool completed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: completed
                ? const Color(0xFF5E968A)
                : const Color(0xFFE7EEF1),
            border: selected
                ? Border.all(
              color: const Color(0xFF075E4D),
              width: 2,
            )
                : null,
            shape: BoxShape.circle,
          ),
          child: completed
              ? Icon(
            selected
                ? Icons.looks_4_rounded
                : Icons.check_rounded,
            size: 14,
            color: Colors.white,
          )
              : null,
        ),

        const SizedBox(height: 3),

        Text(
          day,
          style: GoogleFonts.inter(
            fontSize: 8,
            color: const Color(0xFF6D7976),
          ),
        ),
      ],
    );
  }
}