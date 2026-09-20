import 'package:json_annotation/json_annotation.dart';

part 'enroll_free_request.g.dart';

/// `POST /api/enrollments/free` request body (US-15 scenario 2).
///
/// The only way into a free course: the cart rejects free courses
/// (`commerce.CartItemCreateView`), so free enrollment bypasses cart/checkout
/// entirely.
@JsonSerializable()
class EnrollFreeRequest {
  const EnrollFreeRequest({required this.courseId});

  @JsonKey(name: 'course_id')
  final int courseId;

  factory EnrollFreeRequest.fromJson(Map<String, dynamic> json) =>
      _$EnrollFreeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollFreeRequestToJson(this);
}