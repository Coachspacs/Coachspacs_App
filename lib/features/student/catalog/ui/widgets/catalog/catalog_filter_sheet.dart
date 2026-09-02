import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogFilterSheet extends StatefulWidget {
  const CatalogFilterSheet({
    super.key,
    required this.initialLanguage,
    required this.initialLevel,
    required this.initialPrice,
    required this.onApply,
  });

  final String? initialLanguage;
  final String initialLevel;
  final String initialPrice;

  final void Function(
      String? language,
      String level,
      String price,
      ) onApply;

  @override
  State<CatalogFilterSheet> createState() =>
      _CatalogFilterSheetState();
}

class _CatalogFilterSheetState
    extends State<CatalogFilterSheet> {
  String? selectedLanguage;
  late String selectedLevel;
  late String selectedPrice;

  final List<String> levels = [
    'All Levels',
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  final List<String> prices = [
    'All Prices',
    'Free',
    'Paid',
    'Under \$50',
    '\$50 - \$100',
    '\$100+',
  ];

  @override
  void initState() {
    super.initState();

    selectedLanguage = widget.initialLanguage;
    selectedLevel = widget.initialLevel;
    selectedPrice = widget.initialPrice;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            18,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 16),

              // =========================================
              // LANGUAGE
              // =========================================

              _buildSectionTitle(
                'Language',
                Icons.language_outlined,
              ),

              const SizedBox(height: 9),

              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _buildChoiceChip(
                    title: 'English',
                    selected:
                    selectedLanguage == 'English',
                    onTap: () {
                      setState(() {
                        selectedLanguage =
                        selectedLanguage == 'English'
                            ? null
                            : 'English';
                      });
                    },
                  ),
                  _buildChoiceChip(
                    title: 'Arabic',
                    selected:
                    selectedLanguage == 'Arabic',
                    onTap: () {
                      setState(() {
                        selectedLanguage =
                        selectedLanguage == 'Arabic'
                            ? null
                            : 'Arabic';
                      });
                    },
                  ),
                ],
              ),

              const Divider(height: 24),

              // =========================================
              // LEVEL
              // =========================================

              _buildSectionTitle(
                'Level',
                Icons.layers_outlined,
              ),

              const SizedBox(height: 9),

              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: levels.map((level) {
                  return _buildChoiceChip(
                    title: level,
                    selected:
                    selectedLevel == level,
                    onTap: () {
                      setState(() {
                        selectedLevel = level;
                      });
                    },
                  );
                }).toList(),
              ),

              const Divider(height: 24),

              // =========================================
              // PRICE
              // =========================================

              _buildSectionTitle(
                'Price',
                Icons.attach_money,
              ),

              const SizedBox(height: 9),

              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: prices.map((price) {
                  return _buildChoiceChip(
                    title: price,
                    selected:
                    selectedPrice == price,
                    onTap: () {
                      setState(() {
                        selectedPrice = price;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 22),

              // =========================================
              // APPLY FILTERS
              // =========================================

              Center(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(
                        selectedLanguage,
                        selectedLevel,
                        selectedPrice,
                      );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // =========================================
              // RESET ALL
              // =========================================

              Center(
                child: TextButton(
                  onPressed: _resetFilters,
                  child: Text(
                    'Reset All',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                      const Color(0xFF71827E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // HEADER
  // =====================================================

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          'Filters',
          style: GoogleFonts.inter(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF17332D),
          ),
        ),

        const Spacer(),

        TextButton(
          onPressed: _resetFilters,
          child: Text(
            'Reset all',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),

        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          icon: const Icon(
            Icons.close,
            size: 18,
            color: Color(0xFF52615D),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // SECTION TITLE
  // =====================================================

  Widget _buildSectionTitle(
      String title,
      IconData icon,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: const Color(0xFF075E4D),
        ),

        const SizedBox(width: 6),

        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF293B36),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // CHOICE CHIP
  // =====================================================

  Widget _buildChoiceChip({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(20),
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF075E4D)
                : const Color(0xFFEAF0FC),
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Text(
            selected
                ? '✓ $title'
                : title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: selected
                  ? Colors.white
                  : const Color(0xFF52615D),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // RESET
  // =====================================================

  void _resetFilters() {
    setState(() {
      // No language selected
      selectedLanguage = null;

      // All levels
      selectedLevel = 'All Levels';

      // All prices
      selectedPrice = 'All Prices';
    });
  }
}