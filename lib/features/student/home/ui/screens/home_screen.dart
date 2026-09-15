import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';

import '../../data/models/home_data.dart';
import '../../logic/cubit/home_cubit.dart';
import '../../logic/cubit/home_state.dart';

import '../widgets/category_chips_widget.dart';
import '../widgets/continue_learning_card.dart';
import '../widgets/featured_course_card.dart';
import '../widgets/home_hero_section.dart';
import '../widgets/streak_card.dart';
import '../widgets/top_app_bar_widget.dart';

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
      backgroundColor: const Color(0xFFF7FAF9),

      appBar: const TopAppBarWidget(),

      bottomNavigationBar: const BottomNavBarWidget(
        navType: NavType.student,
        currentIndex: 0,
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),

            HomeLoading() => const _LoadingView(),

            HomeEmpty() => const _EmptyView(),

            HomeError() => _ErrorView(
              message: state.message,
            ),

            HomeOffline() => const _OfflineView(),

            HomeSuccess() => _SuccessView(
              data: state.data,
            ),
          };
        },
      ),
    );
  }
}

// =====================================================
// SUCCESS VIEW
// =====================================================

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    required this.data,
  });

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        bottom: 24,
      ),
      children: [
        // =================================================
        // WELCOME + SEARCH
        // =================================================

        const HomeHeroSection(),

        const SizedBox(height: 26),

        // =================================================
        // STREAK
        // =================================================

        const StreakCard(),

        const SizedBox(height: 28),

        // =================================================
        // CONTINUE LEARNING
        // =================================================

        const _SectionHeader(
          title: 'Continue Learning',
          actionLabel: 'Current Module',
        ),

        const SizedBox(height: 12),

        const ContinueLearningCard(),

        const SizedBox(height: 28),

        // =================================================
        // TOP CATEGORIES
        // =================================================

        _SectionHeader(
          title: 'Top Categories',
          actionLabel: 'See all',
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

        const SizedBox(height: 32),

        // =================================================
        // RECOMMENDED COURSES
        // =================================================

        _SectionHeader(
          title: 'Recommended Courses',
          subtitle: 'Courses picked for your learning journey',
          actionLabel: 'See All',
          onAction: () {
            Navigator.pushNamed(
              context,
              AppRoutes.catalog,
            );
          },
        ),

        const SizedBox(height: 14),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              for (final course in data.featuredCourses) ...[
                FeaturedCourseCard(
                  course: course,
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// SECTION HEADER
// =====================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
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
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF073F38),
                      ),
                    ),

                    if (title == 'Continue Learning')
                      Container(
                        margin: const EdgeInsets.only(
                          left: 7,
                        ),
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF087A65),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: const Color(0xFF71807C),
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: title == 'Continue Learning'
                    ? BoxDecoration(
                  color: const Color(0xFFCDEFE5),
                  borderRadius:
                  BorderRadius.circular(20),
                )
                    : null,
                child: Text(
                  actionLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================
// LOADING
// =====================================================

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

// =====================================================
// EMPTY
// =====================================================

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

// =====================================================
// ERROR
// =====================================================

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

// =====================================================
// OFFLINE
// =====================================================

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

// =====================================================
// MESSAGE STATE
// =====================================================

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
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 52,
              color: const Color(0xFF83918D),
            ),

            const SizedBox(height: 16),

            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF073F38),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF71827E),
              ),
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(
                  l10n.homeRetry,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}