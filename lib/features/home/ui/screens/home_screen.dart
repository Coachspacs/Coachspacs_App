import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/home/data/models/home_data.dart';
import 'package:coach_space/features/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/home/logic/cubit/home_state.dart';
import 'package:coach_space/features/home/ui/widgets/category_chips_widget.dart';
import 'package:coach_space/features/home/ui/widgets/featured_course_card.dart';
import 'package:coach_space/features/home/ui/widgets/faq_widget.dart';
import 'package:coach_space/features/home/ui/widgets/home_hero_section.dart';
import 'package:coach_space/features/home/ui/widgets/join_learning_widget.dart';
import 'package:coach_space/features/home/ui/widgets/search_bar_widget.dart';
import 'package:coach_space/features/home/ui/widgets/testimonials_widget.dart';
import 'package:coach_space/features/home/ui/widgets/top_app_bar_widget.dart';
import 'package:coach_space/features/home/ui/widgets/trending_course_card.dart';
import 'package:coach_space/features/home/ui/widgets/why_coach_space_widget.dart';

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
      bottomNavigationBar: const BottomNavBarWidget(
        currentIndex: 0,
      ),
      backgroundColor: const Color(0xFFF8FBFA),
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
  const _SuccessView({
    required this.data,
  });

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        const HomeHeroSection(),

        const SizedBox(height: 18),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SearchBarWidget(),
        ),

        const SizedBox(height: 26),

        _SectionHeader(
          title: 'Top categories',
          subtitle: 'Discover your next skill',
          actionLabel: 'View all',
          onAction: () {
            Navigator.pushNamed(
              context,
              AppRoutes.catalog,
            );
          },
        ),

        const SizedBox(height: 12),

        CategoryChipsWidget(
          categories: data.categories,
        ),

        const SizedBox(height: 28),

        _SectionHeader(
          title: 'Master your craft',
          subtitle: 'Curated high-impact courses',
          actionLabel: 'View all',
          onAction: () {
            Navigator.pushNamed(
              context,
              AppRoutes.catalog,
            );
          },
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 290,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: data.featuredCourses.length,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 285,
                child: FeaturedCourseCard(
                  course: data.featuredCourses[index],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 32),

        const WhyCoachSpaceWidget(),

        const SizedBox(height: 32),

        const TestimonialsWidget(),

        const SizedBox(height: 32),

        const FaqWidget(),

        const SizedBox(height: 32),

        const JoinLearningWidget(),

        const SizedBox(height: 28),

        if (data.trendingCourses.isNotEmpty) ...[
          _SectionHeader(
            title: 'Trending courses',
            subtitle: 'Popular courses students love',
            actionLabel: 'View all',
            onAction: () {
              Navigator.pushNamed(
                context,
                AppRoutes.catalog,
              );
            },
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                for (final course in data.trendingCourses) ...[
                  TrendingCourseCard(
                    course: course,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF073F38),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF778782),
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF075E4D),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF075E4D),
      ),
    );
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
  const _ErrorView({
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _MessageStateView(
      icon: Icons.error_outline,
      title: l10n.homeErrorTitle,
      message: message ?? l10n.homeErrorSubtitle,
      onRetry: () {
        context.read<HomeCubit>().loadHome();
      },
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
      onRetry: () {
        context.read<HomeCubit>().loadHome();
      },
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimens.stackGapLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 56,
              color: const Color(0xFF83918D),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF073F38),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF71827E),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(
                  context.l10n.homeRetry,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}