import 'package:flutter/material.dart';

class MyPathLevelCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final bool recommended;
  final String? skipText;
  final String? savesText;
  final VoidCallback onTap;

  const MyPathLevelCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    this.recommended = false,
    this.skipText,
    this.savesText,
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
                  ? const Color(0xFF008F68)
                  : const Color(0xFFE0E8ED),
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: selected ? .055 : .025,
                ),
                blurRadius: 9,
                offset: const Offset(0, 3),
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
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: selected
                                      ? const Color(0xFF173E35)
                                      : const Color(0xFF182A36),
                                  height: 1.3,
                                ),
                              ),
                            ),

                            if (selected &&
                                title == 'Advanced') ...[
                              const SizedBox(width: 5),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0AA974),
                                ),
                              ),
                            ],

                            if (recommended) ...[
                              const SizedBox(width: 7),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1C765F),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  'RECOMMENDED',
                                  style: TextStyle(
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 11.5,
                            height: 1.4,
                            color: Color(0xFF667B8E),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 6),

                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? const Color(0xFF07966E)
                            : Colors.transparent,
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF07966E)
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
                  ),
                ],
              ),

              if (selected &&
                  (skipText != null || savesText != null)) ...[
                const SizedBox(height: 12),

                const Divider(
                  height: 1,
                  color: Color(0xFFD4E8DF),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    if (skipText != null)
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bolt_outlined,
                              size: 15,
                              color: Color(0xFF008F68),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                skipText!,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFF08745A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (savesText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFA9E3D0),
                          ),
                        ),
                        child: Text(
                          savesText!,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF08745A),
                          ),
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