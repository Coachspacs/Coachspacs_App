import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

/// `PUT /api/users/me` request body.
///
/// The backend documents no explicit request schema. `full_name` is the only
/// field the same backend exposes as writable on the user serializer
/// (`Register.full_name`), so this payload stays minimal and avoids inventing
/// fields. Phone/job-title are intentionally **not** sent — they have no
/// backend contract.
@JsonSerializable()
class UpdateProfileRequest {
  const UpdateProfileRequest({required this.fullName});

  @JsonKey(name: 'full_name')
  final String fullName;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
