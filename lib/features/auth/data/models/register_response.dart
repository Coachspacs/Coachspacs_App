import 'package:json_annotation/json_annotation.dart';

import 'user_role.dart';

part 'register_response.g.dart';

/// `POST /api/auth/register` successful response body.
///
/// Registration does **not** return JWT tokens — the account is created
/// unverified and must confirm its email before the first login.
@JsonSerializable()
class RegisterResponse {
  const RegisterResponse({
    required this.id,
    required this.email,
    required this.role,
    this.fullName = '',
    this.detail,
  });

  final int id;
  final String email;

  @UserRoleConverter()
  final UserRole role;

  @JsonKey(name: 'full_name', defaultValue: '')
  final String fullName;

  final String? detail;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
