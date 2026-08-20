import 'package:json_annotation/json_annotation.dart';

import 'approval_status.dart';
import 'user_role.dart';

part 'login_response.g.dart';

/// `POST /api/auth/login` successful response body.
///
/// The [role] and [approvalStatus] fields drive the post-login routing
/// decision; they are parsed defensively (see [UserRole], [ApprovalStatus]).
@JsonSerializable()
class LoginResponse {
  const LoginResponse({
    required this.access,
    required this.refresh,
    required this.role,
    required this.approvalStatus,
  });

  final String access;
  final String refresh;

  @UserRoleConverter()
  final UserRole role;

  @ApprovalStatusConverter()
  @JsonKey(name: 'approval_status')
  final ApprovalStatus approvalStatus;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
