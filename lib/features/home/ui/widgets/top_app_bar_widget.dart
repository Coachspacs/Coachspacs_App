import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/features/home/data/models/mock_home_data.dart';

/// Sticky app bar: current user avatar (leading), brand title, notifications
/// (trailing). Leading/actions auto-mirror under RTL so Arabic layouts match
/// the mockup.
class TopAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final avatarUrl = MockHomeData.currentUser.avatarUrl;

    return AppBar(
      leadingWidth: AppDimens.marginMobile + AppDimens.appBarLeadingSize,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppDimens.marginMobile),
        child: CircleAvatar(
          radius: AppDimens.appBarLeadingSize / 2,
          backgroundColor: colorScheme.surfaceContainerHigh,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
          onBackgroundImageError: avatarUrl != null
              ? (Object error, StackTrace? stackTrace) {}
              : null,
          child: avatarUrl == null
              ? Icon(Icons.person, color: colorScheme.onSurface, size: 24)
              : null,
        ),
      ),
      title: Text(
        context.l10n.appTitle,
        style: theme.textTheme.displaySmall?.copyWith(
          color: colorScheme.primaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: AppDimens.marginMobile),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
