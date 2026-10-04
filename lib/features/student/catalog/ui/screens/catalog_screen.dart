import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/core/widgets/empty_state_card.dart';
import 'package:coach_space/core/widgets/error_retry_view.dart';
import 'package:coach_space/core/widgets/selectable_chip_row.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';

import '../widgets/catalog/catalog_course_card.dart';
import '../widgets/catalog/catalog_filter_sheet.dart';
import '../widgets/catalog/catalog_search_bar.dart';
import '../widgets/catalog/catalog_sort_bottom_sheet.dart';
import '../widgets/catalog/catalog_top_bar.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final CatalogCubit _catalogCubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _catalogCubit = getIt<CatalogCubit>()..load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _catalogCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _catalogCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAF9),
        body: SafeArea(
          child: Column(
            children: [
              const CatalogTopBar(),
              Expanded(
                child: BlocBuilder<CatalogCubit, CatalogState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: _catalogCubit.refresh,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.extentAfter < 300) {
                            _catalogCubit.loadMore();
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.catalogExplore,
                                style: GoogleFonts.inter(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF073F38),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                context.l10n.catalogSubtitle,
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CatalogSearchBar(
                                controller: _searchController,
                                onSubmitted: (_) => _applyFilters(),
                              ),
                              const SizedBox(height: 13),
                              _buildCategoryChips(state),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(
                                      icon: Icons.tune_rounded,
                                      label: context.l10n.catalogFilters,
                                      onPressed: _openFilterSheet,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildActionButton(
                                      icon: Icons.sort_rounded,
                                      label: context.l10n.catalogSort,
                                      onPressed: _openSortSheet,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 19),
                              _buildResultsHeader(state),
                              const SizedBox(height: 12),
                              _buildBody(state),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBarWidget(
          navType: NavType.student,
          currentIndex: 1,
        ),
      ),
    );
  }

  Widget _buildResultsHeader(CatalogState state) {
    final totalCount = switch (state) {
      CatalogSuccess(:final totalCount) => totalCount,
      _ => 0,
    };

    return Row(
      children: [
        Text(
          context.l10n.catalogAllCourses,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
        const Spacer(),
        if (totalCount > 0)
          Text(
            context.l10n.catalogCoursesCount('$totalCount'),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
      ],
    );
  }

  Widget _buildBody(CatalogState state) {
    switch (state) {
      case CatalogInitial():
      case CatalogLoading():
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(color: Color(0xFF075E4D)),
          ),
        );
      case CatalogFailure():
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: ErrorRetryView(
              title: localizedFailureMessage(
                context,
                state.kind,
                state.message,
              ),
              onRetry: _catalogCubit.refresh,
            ),
          ),
        );
      case CatalogSuccess():
        if (state.isEmpty) {
          return EmptyStateCard(
            icon: Icons.search_off,
            title: context.l10n.catalogNoCourses,
            hint: context.l10n.catalogTryAdjusting,
            iconBadgeSize: 46,
            iconSize: 45,
            titleFontSize: 16,
            hintFontSize: 12,
          );
        }

        return Column(
          children: [
            for (final course in state.courses)
              CatalogCourseCard(
                course: course,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.courseDetails,
                    arguments: course.id,
                  );
                },
              ),
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(color: Color(0xFF075E4D)),
              ),
            if (state.loadMoreError != null)
              TextButton.icon(
                onPressed: _catalogCubit.loadMore,
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(context.l10n.commonRetry),
              ),
          ],
        );
    }
  }

  Widget _buildCategoryChips(CatalogState state) {
    if (state is! CatalogSuccess) {
      return const SizedBox(height: 38);
    }

    final categories = state.categories;
    if (categories.isEmpty) {
      return const SizedBox(height: 38);
    }

    final selectedCategory = state.filters.category;
    CategoryDto? selectedValue;
    for (final category in categories) {
      if (category.id == selectedCategory) {
        selectedValue = category;
        break;
      }
    }

    return SelectableChipRow<CategoryDto?>(
      selectedValue: selectedValue,
      onSelected: (category) {
        _applyFilters(
          categoryId: category?.id,
          clearCategory: category == null,
        );
      },
      items: [
        SelectableChipItem(value: null, label: context.l10n.homeAll),
        for (final category in categories)
          SelectableChipItem(value: category, label: category.name),
      ],
    );
  }

  void _applyFilters({int? categoryId, bool clearCategory = false}) {
    final current = _catalogCubit.filters;
    final search = _searchController.text.trim();

    _catalogCubit.applyFilters(
      current.copyWith(
        category: categoryId,
        clearCategory: clearCategory,
        search: search.isEmpty ? null : search,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 17, color: const Color(0xFF075E4D)),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF075E4D),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD5E4E0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return CatalogFilterSheet(
          initialFilters: _catalogCubit.filters,
          onApply: (filters) {
            _catalogCubit.applyFilters(filters);
          },
        );
      },
    );
  }

  void _openSortSheet() {
    showCatalogSortSheet(
      context,
      currentOrdering: _catalogCubit.filters.ordering,
      onSelected: (ordering) {
        _catalogCubit.applyFilters(
          _catalogCubit.filters.copyWith(ordering: ordering),
        );
      },
    );
  }
}
