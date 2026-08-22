import 'package:flutter/material.dart';

class SettingsTabs extends StatelessWidget {
  const SettingsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ('Profile', Icons.person_outline),
      ('Learning & Certificates', Icons.school_outlined),
      ('Security', Icons.lock_outline),
      ('Preferences', Icons.settings_outlined),
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == 0;

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF0B624F)
                  : const Color(0xFFF2F5F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  tabs[index].$2,
                  size: 16,
                  color: isSelected
                      ? Colors.white
                      : Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  tabs[index].$1,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}