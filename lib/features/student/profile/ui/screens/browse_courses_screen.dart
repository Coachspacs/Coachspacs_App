import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/browse_courses_cubit.dart';

import '../widgets/browse_courses/browse_courses_header.dart';
import '../widgets/browse_courses/course_card.dart';

class BrowseCoursesScreen extends StatelessWidget {
  const BrowseCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseCoursesCubit>(
      create: (_) => getIt<BrowseCoursesCubit>()..load(),
      child: const _BrowseCoursesView(),
    );
  }
}

class _BrowseCoursesView extends StatefulWidget {
  const _BrowseCoursesView();

  @override
  State<_BrowseCoursesView> createState() => _BrowseCoursesViewState();
}

class _BrowseCoursesViewState extends State<_BrowseCoursesView> {
  CourseFilter _selectedFilter = CourseFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: BlocBuilder<BrowseCoursesCubit, BrowseCoursesState>(
          builder: (context, state) {
            final enrollments = switch (state) {
              BrowseCoursesSuccess(:final enrollments) => enrollments,
              _ => const <EnrollmentDto>[],
            };

            final filtered = _filter(enrollments);
            final inProgressCount = enrollments
                .where((e) => !e.isCompleted)
                .length;
            final completedCount = enrollments.where((e) => e.isCompleted).length;

            return RefreshIndicator(
              onRefresh: () => context.read<BrowseCoursesCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BrowseCoursesHeader(
                          selectedStatus: _selectedFilter,
                          allCount: enrollments.length,
                          inProgressCount: inProgressCount,
                          completedCount: completedCount,
                          onStatusChanged: (filter) {
                            setState(() => _selectedFilter = filter);
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _filterLabel(_selectedFilter),
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF073F38),
                              ),
                            ),
                            Text(
                              l10n.catalogCoursesCount('${filtered.length}'),
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                color: const Color(0xFF899792),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (state is BrowseCoursesLoading ||
                            state is BrowseCoursesInitial)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        else if (state is BrowseCoursesFailure)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Text(
                                    localizedFailureMessage(
                                      context,
                                      state.kind,
                                      state.message,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton.icon(
                                    onPressed: () => context
                                        .read<BrowseCoursesCubit>()
                                        .load(),
                                    icon: const Icon(Icons.refresh_rounded),
                                    label: Text(l10n.commonRetry),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (state is BrowseCoursesEmpty || filtered.isEmpty)
                          _EmptyState(
                            message: l10n.myLearningNoCourses,
                            hint: l10n.myLearningBrowseHint,
                          )
                        else
                          _buildGrid(filtered),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<EnrollmentDto> _filter(List<EnrollmentDto> enrollments) {
    return switch (_selectedFilter) {
      CourseFilter.all => enrollments,
      CourseFilter.inProgress =>
        enrollments.where((e) => !e.isCompleted).toList(growable: false),
      CourseFilter.completed =>
        enrollments.where((e) => e.isCompleted).toList(growable: false),
    };
  }

  String _filterLabel(CourseFilter filter) {
    final l10n = context.l10n;
    return switch (filter) {
      CourseFilter.all => l10n.catalogAllCourses,
      CourseFilter.inProgress => l10n.myLearningInProgress,
      CourseFilter.completed => l10n.myLearningCompleted,
    };
  }

  Widget _buildGrid(List<EnrollmentDto> enrollments) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        Widget card(EnrollmentDto enrollment) => CourseCard(
          title: enrollment.course.title,
          instructor: enrollment.course.instructor.fullName,
          coverImage: enrollment.course.coverImage,
          progressPercent: enrollment.progressPercent,
          isCompleted: enrollment.isCompleted,
          onPressed: () => _openCourse(enrollment.course.id),
          onCertificatePressed: enrollment.isCompleted
              ? () => Navigator.pushNamed(context, AppRoutes.certificates)
              : null,
        );

        if (isMobile) {
          return Column(
            children: enrollments
                .map(
                  (enrollment) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: card(enrollment),
                  ),
                )
                .toList(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.78,
          ),
          itemCount: enrollments.length,
          itemBuilder: (context, index) => card(enrollments[index]),
        );
      },
    );
  }

  void _openCourse(int courseId) {
    Navigator.pushNamed(
      context,
      AppRoutes.courseDetails,
      arguments: courseId,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message, required this.hint});

  final String message;
  final String hint;

  @override
  Widget build(BuildContext context) {
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
          Icon(Icons.menu_book_outlined, size: 45, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            hint,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.catalog),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(context.l10n.myLearningBrowseCourses),
          ),
        ],
      ),
    );
  }
}
