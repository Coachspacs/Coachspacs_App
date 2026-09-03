import 'dart:io';

import 'package:dio/dio.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import '../models/instructor_course_dto.dart';
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
  Future<InstructorCourseDto> createCourse(Map<String, dynamic> data) =>
      _guard(() => _api.createInstructorCourse(data));
  @override
  Future<InstructorCourseDto> updateCourse(int id, Map<String, dynamic> data) =>
      _guard(() => _api.updateInstructorCourse(id, data));
  @override
  Future<void> uploadCoverImage(int id, File image) =>
      _guard(() => _api.uploadInstructorCoverImage(id, image));
  @override
  Future<List<InstructorSectionDto>> getSections(int courseId) async =>
      (await _guard(
        () => _api.getInstructorSections(courseId, 1, 100),
      )).results;
  @override
  Future<InstructorSectionDto> createSection(
    int courseId,
    Map<String, dynamic> data,
  ) => _guard(() => _api.createInstructorSection(courseId, data));
  @override
  Future<InstructorSectionDto> updateSection(
    int id,
    Map<String, dynamic> data,
  ) => _guard(() => _api.updateInstructorSection(id, data));
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
    Map<String, dynamic> data,
  ) => _guard(() => _api.createInstructorLesson(sectionId, data));
  @override
  Future<InstructorLessonDto> updateLesson(int id, Map<String, dynamic> data) =>
      _guard(() => _api.updateInstructorLesson(id, data));
  @override
  Future<void> deleteLesson(int id) =>
      _guard(() => _api.deleteInstructorLesson(id));
  @override
  Future<void> reorderCourse(
    int courseId,
    List<Map<String, dynamic>> sections,
  ) => _guard(
    () => _api.reorderInstructorCourse(courseId, {'sections': sections}),
  );
  @override
  Future<void> submitCourse(int courseId) =>
      _guard(() => _api.submitInstructorCourse(courseId));
}
