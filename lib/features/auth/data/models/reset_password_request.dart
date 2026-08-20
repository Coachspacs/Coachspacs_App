import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

/// `POST /api/auth/password/reset` request body.
@JsonSerializable()
class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.uid,
    required this.token,
    required this.newPassword,
  });

  final String uid;
  final String token;

  @JsonKey(name: 'new_password')
  final String newPassword;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
