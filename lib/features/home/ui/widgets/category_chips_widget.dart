import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/home/data/models/category.dart';

class CategoryChipsWidget extends StatefulWidget {
  const CategoryChipsWidget({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  State<CategoryChipsWidget> createState() =>
      _CategoryChipsWidgetState();
}

class _CategoryChipsWidgetState
    extends State<CategoryChipsWidget> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.auto_awesome_outlined,
    Icons.code,
    Icons.bar_chart_outlined,
    Icons.campaign_outlined,
    Icons.trending_up,
    Icons.design_services_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = widget.categories[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              width: 92,
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? const Color(0xFFE4F5EF)
                    : Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: _selectedIndex == index
                      ? const Color(0xFFB9DED2)
                      : const Color(0xFFDCE7E4),
                ),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    _icons[index % _icons.length],
                    size: 20,
                    color: const Color(0xFF075E4D),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF344842),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}