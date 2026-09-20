import 'package:json_annotation/json_annotation.dart';

part 'instructor_student_dto.g.dart';

/// `GET /api/instructor/courses/{id}/students` item (US-17).
///
/// Every student enrolled in one of the instructor's own courses. Fields match
/// the OpenAPI contract 1:1.
@JsonSerializable()
class InstructorStudentDto {
  const InstructorStudentDto({
    required this.id,
    required this.studentFullName,
    required this.studentEmail,
    required this.enrolledAt,
    required this.progressPercent,
  });

  final int id;
  @JsonKey(name: 'student_full_name')
  final String studentFullName;
  @JsonKey(name: 'student_email')
  final String studentEmail;
  @JsonKey(name: 'enrolled_at')
  final String enrolledAt;
  @JsonKey(name: 'progress_percent')
  final int progressPercent;

  factory InstructorStudentDto.fromJson(Map<String, dynamic> json) =>
      _$InstructorStudentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorStudentDtoToJson(this);
}