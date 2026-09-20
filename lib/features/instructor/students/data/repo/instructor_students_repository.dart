import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/instructor/students/data/models/instructor_student_dto.dart';

/// Contract for `GET /api/instructor/courses/{id}/students` (US-17).
abstract class InstructorStudentsRepository {
  /// Every student enrolled in one of the instructor's own courses.
  Future<PaginatedResponse<InstructorStudentDto>> getCourseStudents(
    int courseId, {
    int page = 1,
    int pageSize = 50,
  });
}