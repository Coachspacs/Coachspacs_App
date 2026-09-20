import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';

import '../widgets/catalog/catalog_course_card.dart';
import '../widgets/catalog/catalog_filter_sheet.dart';
import '../widgets/catalog/catalog_search_bar.dart';
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
        return _buildLoadFailure(
          localizedFailureMessage(context, state.kind, state.message),
        );
      case CatalogSuccess():
        if (state.isEmpty) return _buildEmptyState();

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

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final CategoryDto? category = index == 0 ? null : categories[index - 1];
          final isSelected = selectedCategory == category?.id;

          return GestureDetector(
            onTap: () {
              _applyFilters(
                categoryId: category?.id,
                clearCategory: category == null,
              );
            },
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
                category?.name ?? context.l10n.homeAll,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF344540),
                ),
              ),
            ),
          );
        },
      ),
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
    final currentOrdering = _catalogCubit.filters.ordering;

    showModalBottomSheet(
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
                  title: context.l10n.catalogNewest,
                  ordering: '-created_at',
                  selected: currentOrdering == '-created_at' ||
                      currentOrdering == null,
                ),
                _sortOption(
                  title: context.l10n.catalogPriceLowHigh,
                  ordering: 'price',
                  selected: currentOrdering == 'price',
                ),
                _sortOption(
                  title: context.l10n.catalogPriceHighLow,
                  ordering: '-price',
                  selected: currentOrdering == '-price',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sortOption({
    required String title,
    required String ordering,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _catalogCubit.applyFilters(
          _catalogCubit.filters.copyWith(ordering: ordering),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
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

  Widget _buildLoadFailure(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _catalogCubit.refresh,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(context.l10n.commonRetry),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0EAE7)),
      ),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 45, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            context.l10n.catalogNoCourses,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            context.l10n.catalogTryAdjusting,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
