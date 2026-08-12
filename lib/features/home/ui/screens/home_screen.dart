import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/features/home/data/models/home_data.dart';
import 'package:coach_space/features/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/home/logic/cubit/home_state.dart';
import 'package:coach_space/features/home/ui/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/home/ui/widgets/category_chips_widget.dart';
import 'package:coach_space/features/home/ui/widgets/featured_course_card.dart';
import 'package:coach_space/features/home/ui/widgets/search_bar_widget.dart';
import 'package:coach_space/features/home/ui/widgets/top_app_bar_widget.dart';
import 'package:coach_space/features/home/ui/widgets/trending_course_card.dart';

/// Home (Discovery) screen: assembles the feature and owns its [HomeCubit].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => getIt<HomeCubit>()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBarWidget(),
      bottomNavigationBar: const BottomNavBarWidget(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoading() => const _LoadingView(),
            HomeEmpty() => const _EmptyView(),
            HomeError() => _ErrorView(message: state.message),
            HomeOffline() => const _OfflineView(),
            HomeSuccess() => _SuccessView(data: state.data),
          };
        },
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.only(
        top: AppDimens.stackGapMd,
        bottom: AppDimens.stackGapLg,
      ),
      children: [ 
        const SearchBarWidget(),
        const SizedBox(height: AppDimens.stackGapLg),
        CategoryChipsWidget(categories: data.categories),
        const SizedBox(height: AppDimens.stackGapLg),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
          ),
          child: _SectionHeader(
            title: l10n.homeFeatured,
            actionLabel: l10n.homeViewAll,
          ),
        ),
        const SizedBox(height: AppDimens.stackGapMd),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
          ),
          child: Column(
            children: [
              for (final course in data.featuredCourses) ...[
                FeaturedCourseCard(course: course),
                const SizedBox(height: AppDimens.stackGapMd),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppDimens.stackGapLg),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
          ),
          child: _SectionHeader(title: l10n.homeTrending),
        ),
        const SizedBox(height: AppDimens.stackGapMd),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
          ),
          child: Column(
            children: [
              for (final course in data.trendingCourses) ...[
                TrendingCourseCard(course: course),
                const SizedBox(height: AppDimens.stackGapMd),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel});

  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
            ),
            child: Text(actionLabel!, style: theme.textTheme.labelLarge),
          ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _MessageStateView(
      icon: Icons.inbox_outlined,
      title: l10n.homeEmptyTitle,
      message: l10n.homeEmptySubtitle,
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _MessageStateView(
      icon: Icons.error_outline,
      title: l10n.homeErrorTitle,
      message: message ?? l10n.homeErrorSubtitle,
      onRetry: () => context.read<HomeCubit>().loadHome(),
    );
  }
}

class _OfflineView extends StatelessWidget {
  const _OfflineView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _MessageStateView(
      icon: Icons.wifi_off_outlined,
      title: l10n.homeOfflineTitle,
      message: l10n.homeOfflineSubtitle,
      onRetry: () => context.read<HomeCubit>().loadHome(),
    );
  }
}

class _MessageStateView extends StatelessWidget {
  const _MessageStateView({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.stackGapLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: colorScheme.outline),
            const SizedBox(height: AppDimens.stackGapMd),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppDimens.stackGapSm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimens.stackGapLg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.homeRetry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
