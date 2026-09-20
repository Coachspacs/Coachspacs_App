/// `GET /api/instructor/dashboard` response body (US-17).
///
/// The hosted endpoint reports totals across every course the instructor
/// owns, published or not. Because the OpenAPI document does not pin down the
/// exact key names, parsing is intentionally lenient: each value is looked up
/// under several candidate keys and a missing one simply falls back to `null`
/// (the UI then derives the number from the course list instead).
class InstructorDashboardDto {
  const InstructorDashboardDto({
    this.totalCourses,
    this.totalStudents,
    this.totalRevenue,
    this.totalLessons,
    this.totalDurationMinutes,
    this.draftsCount,
    this.pendingCount,
    this.publishedCount,
    this.rejectedCount,
    this.archivedCount,
  });

  final int? totalCourses;
  final int? totalStudents;
  final String? totalRevenue;
  final int? totalLessons;
  final int? totalDurationMinutes;
  final int? draftsCount;
  final int? pendingCount;
  final int? publishedCount;
  final int? rejectedCount;
  final int? archivedCount;

  factory InstructorDashboardDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    int? asInt(List<String> keys) {
      final value = first(keys);
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return InstructorDashboardDto(
      totalCourses: asInt(const [
        'total_courses',
        'courses_count',
        'course_count',
        'total_course_count',
      ]),
      totalStudents: asInt(const [
        'total_students',
        'students_count',
        'student_count',
        'enrollments_count',
        'total_enrollments',
      ]),
      totalRevenue: first(const [
        'total_revenue',
        'revenue',
        'total_earnings',
        'earnings',
      ])?.toString(),
      totalLessons: asInt(const [
        'total_lessons',
        'lessons_count',
        'total_lesson_count',
      ]),
      totalDurationMinutes: asInt(const [
        'total_duration_minutes',
        'total_minutes',
        'duration_minutes',
      ]),
      draftsCount: asInt(const ['draft_courses', 'drafts', 'draft_count']),
      pendingCount: asInt(const [
        'pending_courses',
        'pending_review',
        'pending_review_count',
        'under_review',
      ]),
      publishedCount: asInt(const [
        'published_courses',
        'published',
        'published_count',
      ]),
      rejectedCount: asInt(const [
        'rejected_courses',
        'rejected',
        'rejected_count',
      ]),
      archivedCount: asInt(const [
        'archived_courses',
        'archived',
        'archived_count',
      ]),
    );
  }

  Map<String, dynamic> toJson() => {
        if (totalCourses != null) 'total_courses': totalCourses,
        if (totalStudents != null) 'total_students': totalStudents,
        if (totalRevenue != null) 'total_revenue': totalRevenue,
        if (totalLessons != null) 'total_lessons': totalLessons,
        if (totalDurationMinutes != null)
          'total_duration_minutes': totalDurationMinutes,
        if (draftsCount != null) 'drafts': draftsCount,
        if (pendingCount != null) 'pending_review': pendingCount,
        if (publishedCount != null) 'published': publishedCount,
        if (rejectedCount != null) 'rejected': rejectedCount,
        if (archivedCount != null) 'archived': archivedCount,
      };
}

/// Fallback value used while a dashboard request is in flight.
const InstructorDashboardDto emptyInstructorDashboard = InstructorDashboardDto();

/// Human-readable duration for the dashboard's "total minutes" figure.
String formatDashboardDuration(int? totalMinutes) {
  if (totalMinutes == null || totalMinutes <= 0) return '0h';
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  if (hours == 0) return '${minutes}m';
  if (minutes == 0) return '${hours}h';
  return '${hours}h ${minutes}m';
}