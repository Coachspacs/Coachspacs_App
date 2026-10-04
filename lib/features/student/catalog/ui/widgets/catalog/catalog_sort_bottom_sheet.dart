import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

/// Shows the catalog sort bottom sheet.
///
/// [onSelected] is invoked with the chosen ordering value after the sheet
/// is dismissed.
Future<void> showCatalogSortSheet(
  BuildContext context, {
  required String? currentOrdering,
  required ValueChanged<String> onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.catalogSortCourses,
                style: GoogleFonts.inter(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF073F38),
                ),
              ),
              const SizedBox(height: 16),
              _sortOption(
                context: sheetContext,
                title: sheetContext.l10n.catalogNewest,
                ordering: '-created_at',
                selected:
                    currentOrdering == '-created_at' || currentOrdering == null,
                onSelected: onSelected,
              ),
              _sortOption(
                context: sheetContext,
                title: sheetContext.l10n.catalogPriceLowHigh,
                ordering: 'price',
                selected: currentOrdering == 'price',
                onSelected: onSelected,
              ),
              _sortOption(
                context: sheetContext,
                title: sheetContext.l10n.catalogPriceHighLow,
                ordering: '-price',
                selected: currentOrdering == '-price',
                onSelected: onSelected,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _sortOption({
  required BuildContext context,
  required String title,
  required String ordering,
  required bool selected,
  required ValueChanged<String> onSelected,
}) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      onSelected(ordering);
    },
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 20,
            color: const Color(0xFF075E4D),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF263B36),
            ),
          ),
        ],
      ),
    ),
  );
}
