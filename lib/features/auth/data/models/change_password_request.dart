import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

/// `PUT /api/auth/password/change` request body (authenticated).
@JsonSerializable()
class ChangePasswordRequest {
  const ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  @JsonKey(name: 'current_password')
  final String currentPassword;

  @JsonKey(name: 'new_password')
  final String newPassword;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
