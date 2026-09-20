// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_student_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorStudentDto _$InstructorStudentDtoFromJson(
  Map<String, dynamic> json,
) => InstructorStudentDto(
  id: (json['id'] as num).toInt(),
  studentFullName: json['student_full_name'] as String,
  studentEmail: json['student_email'] as String,
  enrolledAt: json['enrolled_at'] as String,
  progressPercent: (json['progress_percent'] as num).toInt(),
);

Map<String, dynamic> _$InstructorStudentDtoToJson(
  InstructorStudentDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'student_full_name': instance.studentFullName,
  'student_email': instance.studentEmail,
  'enrolled_at': instance.enrolledAt,
  'progress_percent': instance.progressPercent,
};
