import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';

enum _PriceRange { free, under50, between50and100, above100 }

class CatalogFilterSheet extends StatefulWidget {
  const CatalogFilterSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
  });

  final CatalogFilters initialFilters;
  final ValueChanged<CatalogFilters> onApply;

  @override
  State<CatalogFilterSheet> createState() => _CatalogFilterSheetState();
}

class _CatalogFilterSheetState extends State<CatalogFilterSheet> {
  String? _language;
  String? _level;
  _PriceRange? _priceRange;

  @override
  void initState() {
    super.initState();
    _language = widget.initialFilters.language;
    _level = widget.initialFilters.level;
    _priceRange = _rangeFromFilters(widget.initialFilters);
  }

  static _PriceRange? _rangeFromFilters(CatalogFilters filters) {
    final min = filters.priceMin;
    final max = filters.priceMax;
    if (min == null && max == null) return null;
    if (max != null && max <= 0) return _PriceRange.free;
    if (max != null && max <= 50) return _PriceRange.under50;
    if (min != null && min >= 100) return _PriceRange.above100;
    return _PriceRange.between50and100;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSectionTitle(
                l10n.catalogFilterLanguage,
                Icons.language_outlined,
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _buildChoiceChip(
                    title: l10n.catalogFilterEnglish,
                    selected: _language == 'en',
                    onTap: () => setState(
                      () => _language = _language == 'en' ? null : 'en',
                    ),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogFilterArabic,
                    selected: _language == 'ar',
                    onTap: () => setState(
                      () => _language = _language == 'ar' ? null : 'ar',
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildSectionTitle(l10n.catalogFilterLevel, Icons.layers_outlined),
              const SizedBox(height: 9),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _buildChoiceChip(
                    title: l10n.catalogAllLevels,
                    selected: _level == null,
                    onTap: () => setState(() => _level = null),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogLevelBeginner,
                    selected: _level == 'beginner',
                    onTap: () => setState(() => _level = 'beginner'),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogLevelIntermediate,
                    selected: _level == 'intermediate',
                    onTap: () => setState(() => _level = 'intermediate'),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogLevelAdvanced,
                    selected: _level == 'advanced',
                    onTap: () => setState(() => _level = 'advanced'),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildSectionTitle(
                l10n.catalogFilterPrice,
                Icons.attach_money,
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _buildChoiceChip(
                    title: l10n.catalogAllPrices,
                    selected: _priceRange == null,
                    onTap: () => setState(() => _priceRange = null),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogFilterFree,
                    selected: _priceRange == _PriceRange.free,
                    onTap: () => setState(() => _priceRange = _PriceRange.free),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalogUnder50,
                    selected: _priceRange == _PriceRange.under50,
                    onTap: () =>
                        setState(() => _priceRange = _PriceRange.under50),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalog50to100,
                    selected: _priceRange == _PriceRange.between50and100,
                    onTap: () => setState(
                      () => _priceRange = _PriceRange.between50and100,
                    ),
                  ),
                  _buildChoiceChip(
                    title: l10n.catalog100plus,
                    selected: _priceRange == _PriceRange.above100,
                    onTap: () =>
                        setState(() => _priceRange = _PriceRange.above100),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Center(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _apply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      l10n.catalogApplyFilters,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: TextButton(
                  onPressed: () => setState(() {
                    _language = null;
                    _level = null;
                    _priceRange = null;
                  }),
                  child: Text(
                    l10n.catalogResetAll,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF71827E),
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

  void _apply() {
    final base = widget.initialFilters;

    num? priceMin;
    num? priceMax;
    switch (_priceRange) {
      case _PriceRange.free:
        priceMin = 0;
        priceMax = 0;
      case _PriceRange.under50:
        priceMin = 0;
        priceMax = 49.99;
      case _PriceRange.between50and100:
        priceMin = 50;
        priceMax = 100;
      case _PriceRange.above100:
        priceMin = 100;
        priceMax = null;
      case null:
        priceMin = null;
        priceMax = null;
    }

    widget.onApply(
      base.copyWith(
        language: _language,
        clearLanguage: _language == null,
        level: _level,
        clearLevel: _level == null,
        priceMin: priceMin,
        priceMax: priceMax,
        clearPrice: _priceRange == null,
      ),
    );

    Navigator.pop(context);
  }

  Widget _buildHeader() {
    final l10n = context.l10n;

    return Row(
      children: [
        Text(
          l10n.catalogFilters,
          style: GoogleFonts.inter(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF17332D),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => setState(() {
            _language = null;
            _level = null;
            _priceRange = null;
          }),
          child: Text(
            l10n.catalogResetAll,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
          icon: const Icon(
            Icons.close,
            size: 18,
            color: Color(0xFF52615D),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF075E4D)),
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

  Widget _buildChoiceChip({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF075E4D)
                : const Color(0xFFEAF0FC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            selected ? '✓ $title' : title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? Colors.white : const Color(0xFF52615D),
            ),
          ),
        ),
      ),
    );
  }
}
