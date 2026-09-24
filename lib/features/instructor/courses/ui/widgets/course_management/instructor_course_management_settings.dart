import 'package:flutter/material.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementSettings
    extends StatelessWidget {
  const InstructorCourseManagementSettings({
    super.key,
    required this.course,
  });

  final InstructorCourse course;

  String get _statusLabel => switch (course.status) {
    CourseStatus.published => 'Published',
    CourseStatus.pendingReview => 'Pending Review',
    CourseStatus.draft => 'Draft',
    CourseStatus.rejected => 'Rejected',
    CourseStatus.archived => 'Archived',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InstructorManagementSectionCard(
          title: 'Course Settings',
          child: Column(
            children: [
              InstructorSettingRow(
                icon: Icons.visibility_outlined,
                title: 'Course Visibility',
                value: _statusLabel,
              ),

              InstructorSettingRow(
                icon: Icons.attach_money_rounded,
                title: 'Price',
                value: course.isFree ? 'Free' : '\$${course.price.replaceAll('\$', '')}',
              ),

              InstructorSettingRow(
                icon: Icons.language_outlined,
                title: 'Language',
                value: 'English',
              ),

              InstructorSettingRow(
                icon: Icons.category_outlined,
                title: 'Category',
                value: 'Development',
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // =====================================================
        // DANGER ZONE — DELETE (AVAILABLE FOR ANY STATUS)
        // =====================================================
        InstructorManagementSectionCard(
          title: 'Danger Zone',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Once you delete a course, there is no going back. '
                'This works for courses in any status.',
                style: TextStyle(
                  fontSize: 10.5,
                  height: 1.4,
                  color: Color(0xFF7B8985),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _confirmDeleteCourse(context),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 17,
                  ),
                  label: Text(
                    'Delete Course',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFB3261E),
                    side: const BorderSide(
                      color: Color(0xFFF0D0CB),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // DELETE FLOW
  // =====================================================

  Future<void> _confirmDeleteCourse(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delete Course',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${course.title}"? '
            'This action cannot be undone.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF52635F),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF788681),
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, true),
              child: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB3261E),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await getIt<InstructorCoursesRepository>()
          .deleteCourse(course.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course deleted.'),
          backgroundColor: Color(0xFF075E4D),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.instructorCourses,
        (route) => false,
      );
    } on NetworkException catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizedFailureMessage(
              context,
              error.kind,
              error.message,
            ),
          ),
          backgroundColor: const Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
          backgroundColor: Color(0xFFB3261E),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}