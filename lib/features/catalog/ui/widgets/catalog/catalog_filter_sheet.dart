import 'package:flutter/material.dart';

class CatalogFilterSheet extends StatefulWidget {
  const CatalogFilterSheet({
    super.key,
  });

  @override
  State<CatalogFilterSheet> createState() =>
      _CatalogFilterSheetState();
}

class _CatalogFilterSheetState
    extends State<CatalogFilterSheet> {
  final Set<String> selectedCategories = {
    'Communication',
    'Strategy',
    'Marketing',
    'Design',
    'Development',
    'Data Science',
  };

  String selectedLevel = 'Intermediate';
  String selectedPrice = 'All Prices';
  String selectedLanguage = 'English';

  final List<String> categories = [
    'Leadership',
    'Management',
    'Communication',
    'Strategy',
    'Marketing',
    'Design',
    'Development',
    'Data Science',
  ];

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
    '\$50-\$100',
    '\$100+',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4DEDB),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                _buildHeader(),

                const SizedBox(height: 16),

                _buildSectionTitle(
                  'Category',
                  Icons.grid_view_outlined,
                ),

                const SizedBox(height: 8),

                ...categories.map(
                      (category) => _buildCheckbox(
                    title: category,
                    value: selectedCategories
                        .contains(category),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedCategories.add(
                            category,
                          );
                        } else {
                          selectedCategories.remove(
                            category,
                          );
                        }
                      });
                    },
                  ),
                ),

                const Divider(height: 22),

                _buildSectionTitle(
                  'Level',
                  Icons.layers_outlined,
                ),

                const SizedBox(height: 8),

                ...levels.map(
                      (level) => _buildRadio(
                    title: level,
                    value: selectedLevel == level,
                    onChanged: () {
                      setState(() {
                        selectedLevel = level;
                      });
                    },
                  ),
                ),

                const Divider(height: 22),

                _buildSectionTitle(
                  'Price',
                  Icons.attach_money,
                ),

                const SizedBox(height: 8),

                ...prices.map(
                      (price) => _buildRadio(
                    title: price,
                    value: selectedPrice == price,
                    onChanged: () {
                      setState(() {
                        selectedPrice = price;
                      });
                    },
                  ),
                ),

                const Divider(height: 22),

                _buildSectionTitle(
                  'Language',
                  Icons.language_outlined,
                  showArrow: true,
                ),

                const SizedBox(height: 8),

                _buildRadio(
                  title: 'English',
                  value:
                  selectedLanguage == 'English',
                  onChanged: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });
                  },
                ),

                _buildRadio(
                  title: 'Arabic',
                  value:
                  selectedLanguage == 'Arabic',
                  onChanged: () {
                    setState(() {
                      selectedLanguage = 'Arabic';
                    });
                  },
                ),

                const SizedBox(height: 18),

                // Apply
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Reset
                Center(
                  child: TextButton.icon(
                    onPressed: _resetFilters,
                    icon: const Icon(
                      Icons.refresh,
                      size: 15,
                    ),
                    label: const Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor:
                      const Color(0xFF71827E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Color(0xFF073F38),
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Refine your search',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF84918E),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
      String title,
      IconData icon, {
        bool showArrow = false,
      }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: const Color(0xFF075E4D),
        ),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        Icon(
          showArrow
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_up,
          size: 17,
          color: const Color(0xFF8A9894),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return SizedBox(
      height: 32,
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor:
                const Color(0xFF075E4D),
                side: const BorderSide(
                  color: Color(0xFF899792),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: value
                    ? const Color(0xFF52635F)
                    : const Color(0xFF697773),
                fontWeight: value
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio({
    required String title,
    required bool value,
    required VoidCallback onChanged,
  }) {
    return SizedBox(
      height: 32,
      child: InkWell(
        onTap: onChanged,
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Radio<bool>(
                value: true,
                groupValue: value,
                onChanged: (_) {
                  onChanged();
                },
                activeColor:
                const Color(0xFF075E4D),
                materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF697773),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      selectedCategories.clear();
      selectedLevel = 'All Levels';
      selectedPrice = 'All Prices';
      selectedLanguage = 'English';
    });
  }
}