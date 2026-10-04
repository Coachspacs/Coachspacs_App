import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A single selectable pill inside a [SelectableChipRow].
class SelectableChipItem<T> {
  const SelectableChipItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

/// Horizontally scrolling row of animated selection pills.
///
/// Shared by catalog category filters and order-history status filters.
class SelectableChipRow<T> extends StatelessWidget {
  const SelectableChipRow({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
    this.height = 36,
  });

  final List<SelectableChipItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T> onSelected;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item.value == selectedValue;

          return GestureDetector(
            onTap: () => onSelected(item.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF075E4D) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF075E4D)
                      : const Color(0xFFD3DFDB),
                ),
              ),
              child: Text(
                item.label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF344540),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
