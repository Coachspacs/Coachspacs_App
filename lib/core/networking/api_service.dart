import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/login_response.dart';
import 'package:coach_space/features/auth/data/models/logout_request.dart';
import 'package:coach_space/features/auth/data/models/refresh_token_request.dart';
import 'package:coach_space/features/auth/data/models/refresh_token_response.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/profile/data/models/change_email_request.dart';
import 'package:coach_space/features/student/profile/data/models/confirm_email_change_request.dart';
import 'package:coach_space/features/student/profile/data/models/update_profile_request.dart';
import 'package:coach_space/features/student/profile/data/models/user_profile_model.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';

part 'api_service.g.dart';

/// Typed client for the Coach Space auth API.
///
/// Paths intentionally start with `api/...` (no leading slash) so they are
/// appended to the Dio `baseUrl` and never rewrite the `/api/v1/` style prefix.
/// Auth endpoints live under `/api/auth/` per the live Swagger contract.
@RestApi(baseUrl: '')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('api/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest body);

  @POST('api/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest body);

  @POST('api/auth/refresh')
  Future<RefreshTokenResponse> refresh(@Body() RefreshTokenRequest body);

  /// Idempotent; returns 200 even for already-blacklisted tokens.
  @POST('api/auth/logout')
  Future<void> logout(@Body() LogoutRequest body);

  @POST('api/auth/password/forgot')
  Future<void> forgotPassword(@Body() ForgotPasswordRequest body);

  @POST('api/auth/password/reset')
  Future<void> resetPassword(@Body() ResetPasswordRequest body);

  @PUT('api/auth/password/change')
  Future<void> changePassword(@Body() ChangePasswordRequest body);

  @GET('api/auth/verify-email')
  Future<void> verifyEmail(
    @Query('uid') String uid,
    @Query('token') String token,
  );

  @POST('api/auth/verify-email/resend')
  Future<void> resendVerification(@Body() ResendVerificationRequest body);

  @GET('api/auth/instructor/dashboard')
  Future<void> instructorDashboard();

  @GET('api/users/me')
  Future<UserProfileModel> getMe();

  @PUT('api/users/me')
  Future<UserProfileModel> updateMe(@Body() UpdateProfileRequest body);

  @POST('api/users/me/avatar')
  @MultiPart()
  Future<UserProfileModel> uploadAvatar(@Part(name: 'avatar') File avatar);

  @POST('api/users/me/email/change')
  Future<void> requestEmailChange(@Body() ChangeEmailRequest body);

  @POST('api/users/me/email/confirm')
  Future<void> confirmEmailChange(@Body() ConfirmEmailChangeRequest body);

  @GET('api/catalog/categories')
  Future<List<CategoryDto>> getCategories();

  @GET('api/instructor/courses')
  Future<PaginatedResponse<InstructorCourseDto>> getInstructorCourses(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('api/instructor/courses')
  Future<InstructorCourseDto> createInstructorCourse(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('api/instructor/courses/{id}')
  Future<InstructorCourseDto> updateInstructorCourse(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST('api/instructor/courses/{id}/cover-image')
  @MultiPart()
  Future<void> uploadInstructorCoverImage(
    @Path('id') int id,
    @Part(name: 'cover_image') File image,
  );

  @GET('api/instructor/courses/{courseId}/sections')
  Future<PaginatedResponse<InstructorSectionDto>> getInstructorSections(
    @Path('courseId') int courseId,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('api/instructor/courses/{courseId}/sections')
  Future<InstructorSectionDto> createInstructorSection(
    @Path('courseId') int courseId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('api/instructor/sections/{id}')
  Future<InstructorSectionDto> updateInstructorSection(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('api/instructor/sections/{id}')
  Future<void> deleteInstructorSection(@Path('id') int id);

  @GET('api/instructor/sections/{sectionId}/lessons')
  Future<PaginatedResponse<InstructorLessonDto>> getInstructorLessons(
    @Path('sectionId') int sectionId,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('api/instructor/sections/{sectionId}/lessons')
  Future<InstructorLessonDto> createInstructorLesson(
    @Path('sectionId') int sectionId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('api/instructor/lessons/{id}')
  Future<InstructorLessonDto> updateInstructorLesson(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('api/instructor/lessons/{id}')
  Future<void> deleteInstructorLesson(@Path('id') int id);

  @PUT('api/instructor/courses/{id}/reorder')
  Future<void> reorderInstructorCourse(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST('api/instructor/courses/{id}/submit')
  Future<void> submitInstructorCourse(@Path('id') int id);
}
