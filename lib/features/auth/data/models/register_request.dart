import 'package:json_annotation/json_annotation.dart';

import 'user_role.dart';

part 'register_request.g.dart';

/// `POST /api/auth/register` request body.
///
/// [role] supports the backend-defined values (`student`, `instructor`);
/// admin accounts are created by the backend team only.
@JsonSerializable()
class RegisterRequest {
  const RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
  });

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String password;

  @UserRoleConverter()
  final UserRole role;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
