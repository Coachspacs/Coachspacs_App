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

  test('tolerates null cover_image and video_url from the live API', () {
    final course = CatalogCourseDto.fromJson({
      'id': 6,
      'title': 'Daily Mindfulness Practice',
      'description': 'Short guided practices.',
      'category': {'id': 6, 'name': 'Life & Mindfulness', 'icon': 'leaf'},
      'instructor': {'id': 21, 'full_name': 'Ehsan Coach', 'avatar': ''},
      'level': 'beginner',
      'language': 'ar',
      'price': '0.00',
      'is_free': true,
      'cover_image': null,
      'created_at': '2026-08-24T13:08:23.956954Z',
      'published_at': null,
    });

    final detail = CourseDetailDto.fromJson({
      'id': 6,
      'title': 'Daily Mindfulness Practice',
      'description': 'Short guided practices.',
      'category': {'id': 6, 'name': 'Life & Mindfulness', 'icon': 'leaf'},
      'instructor': {'id': 21, 'full_name': 'Ehsan Coach', 'avatar': null},
      'level': 'beginner',
      'language': 'ar',
      'price': '0.00',
      'is_free': true,
      'cover_image': null,
      'status': 'published',
      'created_at': '2026-08-24T13:08:23.956954Z',
      'published_at': '2026-08-24T13:08:23.797657Z',
      'sections': [
        {
          'id': 7,
          'title': 'Getting Started',
          'order': 1,
          'lessons': [
            {
              'id': 15,
              'title': 'Breathing Techniques',
              'duration_minutes': 8,
              'order': 2,
              'is_preview': false,
              'video_url': null,
            },
          ],
        },
      ],
      'total_lessons': 1,
      'total_duration_minutes': 8,
      'is_enrolled': false,
    });

    expect(course.coverImage, '');
    expect(detail.coverImage, '');
    expect(detail.instructor.avatar, '');
    expect(detail.sections.single.lessons.single.videoUrl, '');
    expect(detail.sections.single.lessons.single.isPreview, isFalse);
  });
}
