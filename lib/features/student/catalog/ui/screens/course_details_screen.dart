import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/course_details_cubit.dart';

import '../widgets/course_details/course_details_curriculum.dart';
import '../widgets/course_details/course_details_hero.dart';
import '../widgets/course_details/course_details_includes.dart';
import '../widgets/course_details/course_details_instructor.dart';
import '../widgets/course_details/course_details_instructor_card.dart';
import '../widgets/course_details/course_details_purchase_card.dart';
import '../widgets/course_details/course_details_top_bar.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late final CourseDetailsCubit _cubit;
  int? _courseId;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CourseDetailsCubit>();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final courseId = switch (arguments) {
      int id => id,
      Map map when map['id'] is int => map['id'] as int,
      _ => null,
    };
    _courseId = courseId;
    if (courseId != null) {
      _cubit.load(courseId);
    } else {
      _cubit.emitInvalidArguments();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAF9),
        body: SafeArea(
          child: Column(
            children: [
              const CourseDetailsTopBar(),
              Expanded(
                child: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
                  builder: (context, state) {
                    return switch (state) {
                      CourseDetailsInitial() ||
                      CourseDetailsLoading() => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF075E4D),
                        ),
                      ),
                      CourseDetailsFailure() => _FailureView(
                        message: localizedFailureMessage(
                          context,
                          state.kind,
                          state.message,
                        ),
                        onRetry: () {
                          final id = _courseId;
                          if (id != null) _cubit.load(id);
                        },
                      ),
                      CourseDetailsSuccess() => _SuccessView(
                        state: state,
                        onRetryLoad: () {
                          final id = _courseId;
                          if (id != null) _cubit.load(id);
                        },
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    required this.state,
    required this.onRetryLoad,
  });

  final CourseDetailsSuccess state;
  final VoidCallback onRetryLoad;

  CourseDetailDto get course => state.course;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final instructor = course.instructor;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseDetailsHero(
            title: course.title,
            description: course.description,
            imagePath: course.coverImage,
            categoryLabel: course.category.name,
          ),
          const SizedBox(height: 14),
          CourseDetailsInstructor(
            instructor: instructor.fullName,
            avatar: instructor.avatar,
          ),
          const SizedBox(height: 12),
          _MetaRow(
            level: course.level,
            language: course.language,
          ),
          const SizedBox(height: 20),
          CourseDetailsPurchaseCard(
            price: '\$${course.price}',
            isFree: course.isFree,
            isEnrolled: state.isEnrolled || course.isEnrolled,
            isBusy: state.isBusy,
            onAddToCart: () => _handleAddToCart(context),
            onBuyNow: () => _handleBuyNow(context),
            onEnrollFree: () => _handleEnrollFree(context),
            onContinue: () => _handleContinue(context),
          ),
          const SizedBox(height: 24),
          _sectionTitle(context.l10n.courseDetailsIncludes),
          const SizedBox(height: 12),
          CourseDetailsIncludes(
            totalDurationMinutes: course.totalDurationMinutes,
            totalLessons: course.totalLessons,
          ),
          const SizedBox(height: 24),
          _sectionTitle(l10n.courseDetailsCurriculum),
          const SizedBox(height: 12),
          CourseDetailsCurriculum(
            sections: course.sections,
            enrollmentId: state.enrollment?.id,
            onLessonTap: (lessonId) {
              final enrollment = state.enrollment;
              if (enrollment == null) return;
              Navigator.pushNamed(
                context,
                AppRoutes.lessonPlayer,
                arguments: {'enrollmentId': enrollment.id, 'lessonId': lessonId},
              );
            },
          ),
          const SizedBox(height: 24),
          _sectionTitle(l10n.courseDetailsAboutInstructor),
          const SizedBox(height: 12),
          CourseDetailsInstructorCard(
            instructor: instructor.fullName,
            avatar: instructor.avatar,
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddToCart(BuildContext context) async {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<CourseDetailsCubit>().addToCart();
    if (!context.mounted) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success
              ? context.l10n.courseDetailsAddedToCart
              : context.l10n.courseDetailsAddToCartFailed,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleBuyNow(BuildContext context) async {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<CourseDetailsCubit>().addToCart();
    if (!context.mounted) return;

    if (success) {
      navigator.pushNamed(AppRoutes.checkout);
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.l10n.courseDetailsAddToCartFailed),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleEnrollFree(BuildContext context) async {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<CourseDetailsCubit>().enrollFree();
    if (!context.mounted) return;

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success
              ? context.l10n.courseDetailsEnrollSuccess
              : context.l10n.courseDetailsEnrollFailed,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleContinue(BuildContext context) {
    final enrollment = state.enrollment;
    final lessonId = _firstLessonId(
      course.sections,
      resumeFrom: enrollment?.lastIncompleteLessonId,
    );
    if (enrollment != null && lessonId != null) {
      Navigator.pushNamed(
        context,
        AppRoutes.lessonPlayer,
        arguments: {'enrollmentId': enrollment.id, 'lessonId': lessonId},
      );
      return;
    }
    Navigator.pushNamed(context, AppRoutes.myLearning);
  }

  int? _firstLessonId(
    List<CourseSectionDto> sections, {
    int? resumeFrom,
  }) {
    if (resumeFrom != null) return resumeFrom;
    final ordered = [...sections]..sort((a, b) => a.order.compareTo(b.order));
    for (final section in ordered) {
      if (section.lessons.isNotEmpty) {
        final lessons = [...section.lessons]
          ..sort((a, b) => a.order.compareTo(b.order));
        return lessons.first.id;
      }
    }
    return null;
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.level, required this.language});

  final String level;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaChip(
          icon: Icons.signal_cellular_alt_rounded,
          label: '${context.l10n.courseDetailsLevel}: $level',
        ),
        const SizedBox(width: 8),
        _MetaChip(
          icon: Icons.language_rounded,
          label: '${context.l10n.courseDetailsLanguage}: $language',
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF075E4D)),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF075E4D),
            ),
          ),
        ],
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
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
              onPressed: onRetry,
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
}
