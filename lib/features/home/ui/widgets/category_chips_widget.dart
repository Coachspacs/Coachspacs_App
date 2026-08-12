import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';
import 'package:coach_space/features/home/data/models/category.dart';

/// Horizontally scrollable category filter chips.
///
/// A leading "All" chip (localized) is always shown, followed by the loaded
/// categories.
class CategoryChipsWidget extends StatefulWidget {
  const CategoryChipsWidget({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<CategoryChipsWidget> createState() => _CategoryChipsWidgetState();
}

class _CategoryChipsWidgetState extends State<CategoryChipsWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final labels = [context.l10n.homeAll, ...widget.categories.map((c) => c.name)];

    return SizedBox(
      height: AppDimens.chipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginMobile),
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppDimens.gutterMobile),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return _CategoryChip(
            label: labels[index],
            selected: isSelected,
            onTap: () => setState(() => _selectedIndex = index),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.stackGapLg),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? colorScheme.primaryContainer : colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: selected
                ? null
                : Border.all(color: colorScheme.outlineVariant),
            boxShadow: selected ? AppShadows.interactive : null,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ),
    );
  }
}
