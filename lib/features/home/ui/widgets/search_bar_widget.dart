import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';

/// Discover search field with the design-system filled style.
class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isFocused = _focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginMobile),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(
            color: isFocused ? colorScheme.primary : colorScheme.outlineVariant,
            width: isFocused ? 2 : 1,
          ),
          boxShadow: AppShadows.card,
        ),
        child: TextField(
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: context.l10n.homeSearchHint,
            hintStyle: theme.textTheme.bodyLarge
                ?.copyWith(color: colorScheme.onSurfaceVariant),
            prefixIcon: Icon(Icons.search, color: colorScheme.outline),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.marginMobile,
              vertical: AppDimens.stackGapMd,
            ),
          ),
        ),
      ),
    );
  }
}
