import 'dart:io';

import 'package:dio/dio.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import '../models/attachment_dto.dart';
import '../models/attachment_write_request.dart';
import '../models/instructor_course_dto.dart';
import '../models/upload_signature_dto.dart';
import 'instructor_courses_repository.dart';

class InstructorCoursesRepositoryImpl implements InstructorCoursesRepository {
  InstructorCoursesRepositoryImpl({required ApiService apiService})
    : _api = apiService;
  final ApiService _api;

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }

  @override
  Future<PaginatedResponse<InstructorCourseDto>> getCourses({
    int page = 1,
    int pageSize = 20,
  }) => _guard(() => _api.getInstructorCourses(page, pageSize));
  @override
  Future<InstructorCourseDto> createCourse(CourseWriteRequest data) =>
      _guard(() => _api.createInstructorCourse(data));
  @override
  Future<InstructorCourseDto> updateCourse(int id, CoursePatchRequest data) =>
      _guard(() => _api.updateInstructorCourse(id, data));
  @override
  Future<InstructorCourseDto> getCourse(int id) =>
      _guard(() => _api.getInstructorCourse(id));
  @override
  Future<InstructorCourseDto> replaceCourse(int id, CourseWriteRequest data) =>
      _guard(() => _api.replaceInstructorCourse(id, data));
  @override
  Future<void> deleteCourse(int id) =>
      _guard(() => _api.deleteInstructorCourse(id));
  @override
  Future<void> uploadCoverImage(int id, File image) =>
      _guard(() => _api.uploadInstructorCoverImage(id, image));
  @override
  Future<UploadSignatureDto> getVideoUploadSignature(int id) =>
      _guard(() => _api.getVideoUploadSignature(id));
  @override
  Future<UploadSignatureDto> getAttachmentUploadSignature(int id) =>
      _guard(() => _api.getAttachmentUploadSignature(id));
  @override
  Future<List<AttachmentDto>> getCourseAttachments(int courseId) async =>
      (await _guard(
        () => _api.getInstructorCourseAttachments(courseId, page: 1, pageSize: 100),
      )).results;
  @override
  Future<AttachmentDto> createCourseAttachment(
    int courseId,
    AttachmentWriteRequest data,
  ) => _guard(() => _api.createInstructorCourseAttachment(courseId, data));
  @override
  Future<List<AttachmentDto>> getLessonAttachments(int lessonId) async =>
      (await _guard(
        () => _api.getInstructorLessonAttachments(lessonId, page: 1, pageSize: 100),
      )).results;
  @override
  Future<AttachmentDto> createLessonAttachment(
    int lessonId,
    AttachmentWriteRequest data,
  ) => _guard(() => _api.createInstructorLessonAttachment(lessonId, data));
  @override
  Future<AttachmentDto> getAttachment(int id) =>
      _guard(() => _api.getInstructorAttachment(id));
  @override
  Future<AttachmentDto> updateAttachment(int id, AttachmentWriteRequest data) =>
      _guard(() => _api.updateInstructorAttachment(id, data));
  @override
  Future<void> deleteAttachment(int id) =>
      _guard(() => _api.deleteInstructorAttachment(id));
  @override
  Future<List<InstructorSectionDto>> getSections(int courseId) async =>
      (await _guard(
        () => _api.getInstructorSections(courseId, 1, 100),
      )).results;
  @override
  Future<InstructorSectionDto> createSection(
    int courseId,
    SectionWriteRequest data,
  ) => _guard(() => _api.createInstructorSection(courseId, data));
  @override
  Future<InstructorSectionDto> updateSection(
    int id,
    SectionPatchRequest data,
  ) => _guard(() => _api.updateInstructorSection(id, data));
  @override
  Future<InstructorSectionDto> getSection(int id) =>
      _guard(() => _api.getInstructorSection(id));
  @override
  Future<InstructorSectionDto> replaceSection(
    int id,
    SectionWriteRequest data,
  ) => _guard(() => _api.replaceInstructorSection(id, data));
  @override
  Future<void> deleteSection(int id) =>
      _guard(() => _api.deleteInstructorSection(id));
  @override
  Future<List<InstructorLessonDto>> getLessons(int sectionId) async =>
      (await _guard(
        () => _api.getInstructorLessons(sectionId, 1, 100),
      )).results;
  @override
  Future<InstructorLessonDto> createLesson(
    int sectionId,
    LessonWriteRequest data,
  ) => _guard(() => _api.createInstructorLesson(sectionId, data));
  @override
  Future<InstructorLessonDto> updateLesson(int id, LessonPatchRequest data) =>
      _guard(() => _api.updateInstructorLesson(id, data));
  @override
  Future<InstructorLessonDto> getLesson(int id) =>
      _guard(() => _api.getInstructorLesson(id));
  @override
  Future<InstructorLessonDto> replaceLesson(int id, LessonWriteRequest data) =>
      _guard(() => _api.replaceInstructorLesson(id, data));
  @override
  Future<void> deleteLesson(int id) =>
      _guard(() => _api.deleteInstructorLesson(id));
  @override
  Future<void> reorderCourse(
    int courseId,
    List<SectionReorderRequest> sections,
  ) => _guard(
    () => _api.reorderInstructorCourse(
      courseId,
      CourseReorderRequest(sections: sections),
    ),
  );
  @override
  Future<void> submitCourse(int courseId) =>
      _guard(() => _api.submitInstructorCourse(courseId));
}
