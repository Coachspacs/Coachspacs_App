import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/features/auth/data/models/approval_status.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';

part 'user_profile_model.g.dart';

/// `GET /api/users/me` / `PUT /api/users/me` / `POST /api/users/me/avatar`
/// response body.
///
/// The OpenAPI schema documents no body for these endpoints, so fields are
/// defensive: every key beyond `id` is optional and missing/unknown values
/// degrade gracefully instead of throwing. Field names follow the exact
/// serializer conventions visible on the same backend (`full_name`, `role`,
/// `approval_status`, `avatar`).
@JsonSerializable()
class UserProfileModel {
  const UserProfileModel({
    required this.id,
    this.fullName,
    this.email,
    this.role,
    this.approvalStatus,
    this.avatar,
  });

  final int id;

  @JsonKey(name: 'full_name')
  final String? fullName;

  final String? email;

  @UserRoleConverter()
  final UserRole? role;

  @ApprovalStatusConverter()
  @JsonKey(name: 'approval_status')
  final ApprovalStatus? approvalStatus;

  final String? avatar;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
