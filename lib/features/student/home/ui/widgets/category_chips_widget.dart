import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

import '../../data/models/category.dart';

class CategoryChipsWidget extends StatelessWidget {
  const CategoryChipsWidget({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  static const List<IconData> _icons = [
    Icons.laptop_mac_rounded,
    Icons.rocket_launch_rounded,
    Icons.trending_up_rounded,
    Icons.auto_awesome_rounded,
    Icons.code_rounded,
    Icons.design_services_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final visibleCategories =
    categories.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visibleCategories.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.65,
        ),
        itemBuilder: (context, index) {
          final category =
          visibleCategories[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFDCE7F7),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08075E4D),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius:
                    BorderRadius.circular(11),
                  ),
                  child: Icon(
                    _icons[
                    index % _icons.length],
                    size: 20,
                    color: const Color(0xFF075E4D),
                  ),
                ),

                const Spacer(),

                Text(
                  category.name,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF182432),
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration:
                      const BoxDecoration(
                        color: Color(0xFF5EE0C5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      context.l10n.homeCategoryCourses,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: const Color(0xFF52615D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}