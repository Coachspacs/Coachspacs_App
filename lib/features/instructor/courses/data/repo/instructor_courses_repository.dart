import 'dart:io';

import 'package:coach_space/core/networking/paginated_response.dart';

import '../models/instructor_course_dto.dart';

abstract class InstructorCoursesRepository {
  Future<PaginatedResponse<InstructorCourseDto>> getCourses({
    int page = 1,
    int pageSize = 20,
  });
  Future<InstructorCourseDto> createCourse(CourseWriteRequest data);
  Future<InstructorCourseDto> updateCourse(int id, CoursePatchRequest data);
  Future<InstructorCourseDto> getCourse(int id);
  Future<InstructorCourseDto> replaceCourse(int id, CourseWriteRequest data);
  Future<void> deleteCourse(int id);
  Future<void> uploadCoverImage(int id, File image);
  Future<void> getVideoUploadSignature(int id);
  Future<List<InstructorSectionDto>> getSections(int courseId);
  Future<InstructorSectionDto> createSection(
    int courseId,
    SectionWriteRequest data,
  );
  Future<InstructorSectionDto> updateSection(int id, SectionPatchRequest data);
  Future<InstructorSectionDto> getSection(int id);
  Future<InstructorSectionDto> replaceSection(int id, SectionWriteRequest data);
  Future<void> deleteSection(int id);
  Future<List<InstructorLessonDto>> getLessons(int sectionId);
  Future<InstructorLessonDto> createLesson(
    int sectionId,
    LessonWriteRequest data,
  );
  Future<InstructorLessonDto> updateLesson(int id, LessonPatchRequest data);
  Future<InstructorLessonDto> getLesson(int id);
  Future<InstructorLessonDto> replaceLesson(int id, LessonWriteRequest data);
  Future<void> deleteLesson(int id);
  Future<void> reorderCourse(
    int courseId,
    List<SectionReorderRequest> sections,
  );
  Future<void> submitCourse(int courseId);
}
