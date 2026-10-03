import 'package:flutter/material.dart';

class MyPathGoalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final String? badge;
  final String? recommendedText;
  final String? activeText;
  final VoidCallback onTap;

  const MyPathGoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    this.badge,
    this.recommendedText,
    this.activeText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEAF7F1)
                : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? const Color(0xFF075E4D)
                  : const Color(0xFFE0E9E7),
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: selected ? .06 : .035,
                ),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF075E4D)
                          : const Color(0xFFF0F4F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 21,
                      color: selected
                          ? Colors.white
                          : const Color(0xFF53677A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF182A36),
                                  height: 1.35,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (badge != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF0C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  badge!,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFB86B00),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 11.5,
                            height: 1.45,
                            color: Color(0xFF667B8E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? const Color(0xFF075E4D)
                          : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF075E4D)
                            : const Color(0xFFC7D5E2),
                        width: 2,
                      ),
                    ),
                    child: selected
                        ? const Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ],
              ),

              if (selected &&
                  (recommendedText != null || activeText != null)) ...[
                const SizedBox(height: 12),
                const Divider(
                  height: 1,
                  color: Color(0xFFD4E8DF),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (recommendedText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFBFE4D6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: Color(0xFF075E4D),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              recommendedText!,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF075E4D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    if (activeText != null)
                      Text(
                        activeText!,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF075E4D),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}