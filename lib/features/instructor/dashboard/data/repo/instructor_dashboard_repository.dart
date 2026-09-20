import 'package:coach_space/features/instructor/dashboard/data/models/instructor_dashboard_dto.dart';

/// Contract for `GET /api/instructor/dashboard` (US-17 scenarios 1, 5).
abstract class InstructorDashboardRepository {
  /// Totals across every course this instructor owns, published or not.
  Future<InstructorDashboardDto> getDashboard();
}