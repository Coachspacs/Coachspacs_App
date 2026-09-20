import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

abstract class EnrollmentRepository {
  Future<PaginatedResponse<EnrollmentDto>> getEnrollments({
    int page = 1,
    int pageSize = 20,
  });

  /// Enrolls the signed-in student in a free course, bypassing cart/checkout
  /// entirely (`POST /api/enrollments/free`).
  Future<void> enrollFree(int courseId);

  Future<LessonPlayerDto> getLesson(int enrollmentId, int lessonId);
  Future<void> markLessonComplete(int enrollmentId, int lessonId);
  Future<void> markLessonIncomplete(int enrollmentId, int lessonId);
}
