import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'paginated_response.dart';

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
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_detail_dto.dart';
import 'package:coach_space/features/student/profile/data/models/change_email_request.dart';
import 'package:coach_space/features/student/profile/data/models/confirm_email_change_request.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/models/roadmap_dtos.dart';
import 'package:coach_space/features/student/profile/data/models/update_profile_request.dart';
import 'package:coach_space/features/student/profile/data/models/user_profile_model.dart';
import 'package:coach_space/features/instructor/courses/data/models/attachment_dto.dart';
import 'package:coach_space/features/instructor/courses/data/models/attachment_write_request.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/models/upload_signature_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/ai_quiz_dtos.dart';
import 'package:coach_space/features/student/my_learning/data/models/lesson_summary_dto.dart';
import 'package:coach_space/features/instructor/dashboard/data/models/instructor_dashboard_dto.dart';
import 'package:coach_space/features/instructor/students/data/models/instructor_student_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/enroll_free_request.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';

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

  @GET('api/users/me')
  Future<UserProfileModel> getMe();

  @PUT('api/users/me')
  Future<UserProfileModel> updateMe(@Body() UpdateProfileRequest body);

  @POST('api/users/me/avatar')
  @MultiPart()
  Future<void> uploadAvatar(@Part(name: 'avatar') File avatar);

  @POST('api/users/me/email/change')
  Future<void> requestEmailChange(@Body() ChangeEmailRequest body);

  @POST('api/users/me/email/confirm')
  Future<void> confirmEmailChange(@Body() ConfirmEmailChangeRequest body);

  @GET('api/catalog/categories')
  Future<List<CategoryDto>> getCategories();

  @GET('api/catalog/courses')
  Future<PaginatedResponse<CatalogCourseDto>> getCatalogCourses({
    @Query('category') int? category,
    @Query('language') String? language,
    @Query('level') String? level,
    @Query('price_min') num? priceMin,
    @Query('price_max') num? priceMax,
    @Query('search') String? search,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('api/catalog/courses/{id}')
  Future<CourseDetailDto> getCatalogCourse(@Path('id') int id);

  @GET('api/enrollments')
  Future<PaginatedResponse<EnrollmentDto>> getEnrollments(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  /// The only path into a free course (see US-15): free courses are never
  /// added to the cart, so checkout is bypassed entirely.
  @POST('api/enrollments/free')
  Future<void> enrollFree(@Body() EnrollFreeRequest body);

  @GET('api/enrollments/{enrollmentId}/lessons/{lessonId}')
  Future<LessonPlayerDto> getEnrollmentLesson(
    @Path('enrollmentId') int enrollmentId,
    @Path('lessonId') int lessonId,
  );

  @POST('api/enrollments/{enrollmentId}/lessons/{lessonId}/complete')
  Future<void> markLessonComplete(
    @Path('enrollmentId') int enrollmentId,
    @Path('lessonId') int lessonId,
  );

  @DELETE('api/enrollments/{enrollmentId}/lessons/{lessonId}/complete')
  Future<void> markLessonIncomplete(
    @Path('enrollmentId') int enrollmentId,
    @Path('lessonId') int lessonId,
  );

  @GET('api/instructor/courses')
  Future<PaginatedResponse<InstructorCourseDto>> getInstructorCourses(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('api/instructor/courses')
  Future<InstructorCourseDto> createInstructorCourse(
    @Body() CourseWriteRequest body,
  );

  @PATCH('api/instructor/courses/{id}')
  Future<InstructorCourseDto> updateInstructorCourse(
    @Path('id') int id,
    @Body() CoursePatchRequest body,
  );

  @GET('api/instructor/courses/{id}')
  Future<InstructorCourseDto> getInstructorCourse(@Path('id') int id);

  @PUT('api/instructor/courses/{id}')
  Future<InstructorCourseDto> replaceInstructorCourse(
    @Path('id') int id,
    @Body() CourseWriteRequest body,
  );

  @DELETE('api/instructor/courses/{id}')
  Future<void> deleteInstructorCourse(@Path('id') int id);

  @POST('api/instructor/courses/{id}/cover-image')
  @MultiPart()
  Future<void> uploadInstructorCoverImage(
    @Path('id') int id,
    @Part(name: 'cover_image') File image,
  );

  /// Hands the frontend a short-lived, folder-scoped Cloudinary signature so
  /// it can upload the video file directly to Cloudinary; the frontend then
  /// creates/updates the Lesson with the resulting public_id.
  @POST('api/instructor/courses/{id}/video-upload-signature')
  Future<UploadSignatureDto> getVideoUploadSignature(@Path('id') int id);

  /// Same shape as the video signature, for course/lesson attachments (US-21).
  @POST('api/instructor/courses/{id}/attachment-upload-signature')
  Future<UploadSignatureDto> getAttachmentUploadSignature(@Path('id') int id);

  @GET('api/instructor/courses/{courseId}/sections')
  Future<PaginatedResponse<InstructorSectionDto>> getInstructorSections(
    @Path('courseId') int courseId,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('api/instructor/courses/{courseId}/sections')
  Future<InstructorSectionDto> createInstructorSection(
    @Path('courseId') int courseId,
    @Body() SectionWriteRequest body,
  );

  @PATCH('api/instructor/sections/{id}')
  Future<InstructorSectionDto> updateInstructorSection(
    @Path('id') int id,
    @Body() SectionPatchRequest body,
  );

  @GET('api/instructor/sections/{id}')
  Future<InstructorSectionDto> getInstructorSection(@Path('id') int id);

  @PUT('api/instructor/sections/{id}')
  Future<InstructorSectionDto> replaceInstructorSection(
    @Path('id') int id,
    @Body() SectionWriteRequest body,
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
    @Body() LessonWriteRequest body,
  );

  @PATCH('api/instructor/lessons/{id}')
  Future<InstructorLessonDto> updateInstructorLesson(
    @Path('id') int id,
    @Body() LessonPatchRequest body,
  );

  @GET('api/instructor/lessons/{id}')
  Future<InstructorLessonDto> getInstructorLesson(@Path('id') int id);

  @PUT('api/instructor/lessons/{id}')
  Future<InstructorLessonDto> replaceInstructorLesson(
    @Path('id') int id,
    @Body() LessonWriteRequest body,
  );

  @DELETE('api/instructor/lessons/{id}')
  Future<void> deleteInstructorLesson(@Path('id') int id);

  @PUT('api/instructor/courses/{id}/reorder')
  Future<void> reorderInstructorCourse(
    @Path('id') int id,
    @Body() CourseReorderRequest body,
  );

  @POST('api/instructor/courses/{id}/submit')
  Future<void> submitInstructorCourse(@Path('id') int id);

  /// Every student enrolled in one of this instructor's own courses (US-17).
  @GET('api/instructor/courses/{id}/students')
  Future<PaginatedResponse<InstructorStudentDto>> getInstructorCourseStudents(
    @Path('id') int id, {
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  /// Totals across every course this instructor owns (US-17 scenarios 1, 5).
  @GET('api/instructor/dashboard')
  Future<InstructorDashboardDto> getInstructorDashboard();

  /// Redirects to the signed media URL; the OpenAPI document has no body.
  @GET('api/media/stream')
  Future<void> streamMedia(@Query('token') String token);

  // ===========================================================
  // CART
  // ===========================================================

  @GET('api/cart')
  Future<CartDto> getCart();

  /// The API returns 200 with an empty body (see OpenAPI `No response body`).
  @POST('api/cart/items')
  Future<void> addCartItem(@Body() AddCartItemRequest body);

  @DELETE('api/cart/items/{id}')
  Future<void> removeCartItem(@Path('id') int id);

  // ===========================================================
  // ORDERS
  // ===========================================================

  @GET('api/orders')
  Future<PaginatedResponse<OrderDto>> getOrders({
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  /// Starts a Stripe Checkout Session for the signed-in student's cart
  /// (US-15). Returns the hosted `checkout_url` for the frontend to redirect
  /// to; the order stays pending until Stripe's webhook confirms it.
  /// The API spec takes no request body.
  @POST('api/orders/checkout')
  Future<CheckoutSessionDto> checkout();

  // ===========================================================
  // CERTIFICATES
  // ===========================================================

  @GET('api/certificates')
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('api/certificates/{id}')
  Future<CertificateDetailDto> getCertificate(@Path('id') int id);

  /// Public, unauthenticated certificate lookup (US-18). The server rejects a
  /// malformed code with 400 and returns 404 for a well-formed unknown one.
  @GET('api/certificates/verify/{code}')
  Future<CertificateVerifyDto> verifyCertificate(@Path('code') String code);

  // ===========================================================
  // AI ROADMAP (US-18)
  // ===========================================================

  /// The signed-in student's active learning path, or `{"path": null}` when
  /// none has been generated yet (the cue to show the My Path wizard).
  @GET('api/ai/roadmap')
  Future<RoadmapResponseDto> getRoadmap();

  /// Builds a new path. A student who already has an active path must use
  /// [regenerateRoadmap] instead — the server rejects a repeat generate.
  @POST('api/ai/roadmap/generate')
  Future<RoadmapResponseDto> generateRoadmap(
    @Body() RoadmapGenerateRequest body,
  );

  /// Rebuilds the path around changed inputs; the previous path is archived
  /// only once the new one has actually been built.
  @POST('api/ai/roadmap/regenerate')
  Future<RoadmapResponseDto> regenerateRoadmap(
    @Body() RoadmapRegenerateRequest body,
  );

  /// Skips (`status: skipped`), restores (`status: pending`) or reorders
  /// (1-based [RoadmapStepUpdateRequest.order]) a step of the active path.
  @PATCH('api/ai/roadmap/steps/{id}')
  Future<void> updateRoadmapStep(
    @Path('id') int id,
    @Body() RoadmapStepUpdateRequest body,
  );

  // ===========================================================
  // AI QUIZZES
  // ===========================================================

  /// Starts async quiz generation from the given lessons; the response is a
  /// pending quiz the client polls via [getAIQuiz] until ready/failed.
  @POST('api/courses/{id}/ai-quizzes')
  Future<AIQuizDto> startAIQuiz(@Path('id') int id, @Body() AIQuizStartRequest body);

  /// Lists the student's own quizzes for one course.
  @GET('api/courses/{id}/ai-quizzes')
  Future<List<AIQuizDto>> getCourseAIQuizzes(@Path('id') int id);

  /// Strictly the student's own quiz — anyone else's is a 404, not a 403.
  /// Returns the status to poll on and, once ready, the questions.
  @GET('api/ai-quizzes/{id}')
  Future<AIQuizDto> getAIQuiz(@Path('id') int id);

  /// The only response that reveals correct answers and explanations.
  @POST('api/ai-quizzes/{id}/submit')
  Future<AIQuizResultDto> submitAIQuiz(
    @Path('id') int id,
    @Body() AIQuizSubmitRequest body,
  );

  // ===========================================================
  // LESSON SUMMARY (US-19)
  // ===========================================================

  /// AI summary of one lesson; language follows the Accept-Language header.
  @GET('api/lessons/{id}/summary')
  Future<LessonSummaryDto> getLessonSummary(@Path('id') int id);

  // ===========================================================
  // COURSE MATERIALS / ATTACHMENTS (US-21)
  // ===========================================================

  /// A preview lesson's attachment is public; anything else needs enrollment
  /// or instructor ownership. The server answers with a redirect to the
  /// signed Cloudinary asset — fetch the bytes with an authenticated client.
  @GET('api/catalog/attachments/{id}/download')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadCourseAttachment(@Path('id') int id);

  @GET('api/instructor/courses/{courseId}/attachments')
  Future<PaginatedResponse<AttachmentDto>> getInstructorCourseAttachments(
    @Path('courseId') int courseId, {
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @POST('api/instructor/courses/{courseId}/attachments')
  Future<AttachmentDto> createInstructorCourseAttachment(
    @Path('courseId') int courseId,
    @Body() AttachmentWriteRequest body,
  );

  @GET('api/instructor/lessons/{lessonId}/attachments')
  Future<PaginatedResponse<AttachmentDto>> getInstructorLessonAttachments(
    @Path('lessonId') int lessonId, {
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @POST('api/instructor/lessons/{lessonId}/attachments')
  Future<AttachmentDto> createInstructorLessonAttachment(
    @Path('lessonId') int lessonId,
    @Body() AttachmentWriteRequest body,
  );

  @GET('api/instructor/attachments/{id}')
  Future<AttachmentDto> getInstructorAttachment(@Path('id') int id);

  @PATCH('api/instructor/attachments/{id}')
  Future<AttachmentDto> updateInstructorAttachment(
    @Path('id') int id,
    @Body() AttachmentWriteRequest body,
  );

  @DELETE('api/instructor/attachments/{id}')
  Future<void> deleteInstructorAttachment(@Path('id') int id);

}
