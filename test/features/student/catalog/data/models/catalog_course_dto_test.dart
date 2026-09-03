import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deserializes computed scalar fields returned as strings', () {
    final course = CourseDetailDto.fromJson({
      'id': 1,
      'title': 'Flutter',
      'description': 'A course',
      'category': {'id': 2, 'name': 'Development', 'icon': ''},
      'instructor': {'id': 3, 'full_name': 'Coach', 'avatar': ''},
      'level': 'beginner',
      'language': 'en',
      'price': '0',
      'is_free': 'true',
      'cover_image': '',
      'status': 'published',
      'created_at': '2026-09-03T09:08:08.101Z',
      'sections': <Object?>[],
      'total_lessons': '8',
      'total_duration_minutes': '90',
      'is_enrolled': 'false',
    });

    expect(course.isFree, isTrue);
    expect(course.totalLessons, 8);
    expect(course.totalDurationMinutes, 90);
    expect(course.isEnrolled, isFalse);
  });
}
