part of 'instructor_students_cubit.dart';

sealed class InstructorStudentsState {
  const InstructorStudentsState();
}

final class InstructorStudentsInitial extends InstructorStudentsState {
  const InstructorStudentsInitial();
}

final class InstructorStudentsLoading extends InstructorStudentsState {
  const InstructorStudentsLoading();
}

final class InstructorStudentsSuccess extends InstructorStudentsState {
  const InstructorStudentsSuccess({
    required this.students,
    required this.courses,
  });

  /// Every student enrolled in any of the instructor's courses, deduplicated
  /// by email across courses.
  final List<EnrolledStudent> students;

  /// The instructor's own courses, used for the per-course filter.
  final List<InstructorCourseDto> courses;

  int get totalStudents => students.length;

  int get activeStudents => students
      .where((entry) => entry.progressPercent > 0 && entry.progressPercent < 100)
      .length;

  int get completedStudents =>
      students.where((entry) => entry.progressPercent >= 100).length;
}

final class InstructorStudentsFailure extends InstructorStudentsState {
  const InstructorStudentsFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}

/// A student bound to the course they were reported under.
class EnrolledStudent {
  const EnrolledStudent({
    required this.student,
    required this.courseId,
    required this.courseName,
  });

  final InstructorStudentDto student;
  final int courseId;
  final String courseName;

  String get name =>
      student.studentFullName.isNotEmpty ? student.studentFullName : '—';
  String get email => student.studentEmail;
  String get initials => _initials(student.studentFullName);
  int get progressPercent => student.progressPercent.clamp(0, 100);
  String get courseTitle => courseName;

  bool get isCompleted => progressPercent >= 100;
  bool get isInactive => progressPercent <= 0;

  static String _initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}