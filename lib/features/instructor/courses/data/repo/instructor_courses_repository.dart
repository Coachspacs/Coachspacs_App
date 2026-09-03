import 'dart:io';

import '../models/instructor_course_dto.dart';

abstract class InstructorCoursesRepository {
  Future<PaginatedResponse<InstructorCourseDto>> getCourses({
    int page = 1,
    int pageSize = 20,
  });
  Future<InstructorCourseDto> createCourse(Map<String, dynamic> data);
  Future<InstructorCourseDto> updateCourse(int id, Map<String, dynamic> data);
  Future<void> uploadCoverImage(int id, File image);
  Future<List<InstructorSectionDto>> getSections(int courseId);
  Future<InstructorSectionDto> createSection(
    int courseId,
    Map<String, dynamic> data,
  );
  Future<InstructorSectionDto> updateSection(int id, Map<String, dynamic> data);
  Future<void> deleteSection(int id);
  Future<List<InstructorLessonDto>> getLessons(int sectionId);
  Future<InstructorLessonDto> createLesson(
    int sectionId,
    Map<String, dynamic> data,
  );
  Future<InstructorLessonDto> updateLesson(int id, Map<String, dynamic> data);
  Future<void> deleteLesson(int id);
  Future<void> reorderCourse(int courseId, List<Map<String, dynamic>> sections);
  Future<void> submitCourse(int courseId);
}
