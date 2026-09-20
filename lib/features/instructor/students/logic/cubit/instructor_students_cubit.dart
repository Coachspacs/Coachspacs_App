import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/students/data/models/instructor_student_dto.dart';
import 'package:coach_space/features/instructor/students/data/repo/instructor_students_repository.dart';

part 'instructor_students_state.dart';

/// Loads the instructor's courses and, for each one, its enrolled students
/// (`GET /api/instructor/courses/{id}/students`). Students are merged across
/// courses (deduplicated by email) so the students screen can list everyone
/// enrolled in the instructor's catalog and filter per course in the UI.
class InstructorStudentsCubit extends Cubit<InstructorStudentsState> {
  InstructorStudentsCubit({
    required InstructorStudentsRepository studentsRepository,
    required InstructorCoursesRepository coursesRepository,
  }) : _studentsRepository = studentsRepository,
       _coursesRepository = coursesRepository,
       super(const InstructorStudentsInitial());

  final InstructorStudentsRepository _studentsRepository;
  final InstructorCoursesRepository _coursesRepository;

  Future<void> load() async {
    emit(const InstructorStudentsLoading());
    try {
      final courses = await _loadCourses();
      final students = <EnrolledStudent>[];
      for (final course in courses) {
        final page = await _studentsRepository.getCourseStudents(
          course.id,
          pageSize: 50,
        );
        for (final student in page.results) {
          students.add(
            EnrolledStudent(
              student: student,
              courseId: course.id,
              courseName: course.displayTitle,
            ),
          );
        }
      }
      emit(
        InstructorStudentsSuccess(
          students: students,
          courses: courses,
        ),
      );
    } on NetworkException catch (error) {
      emit(InstructorStudentsFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const InstructorStudentsFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<List<InstructorCourseDto>> _loadCourses() async {
    try {
      final page = await _coursesRepository.getCourses(pageSize: 100);
      return page.results;
    } on NetworkException {
      return const [];
    }
  }
}