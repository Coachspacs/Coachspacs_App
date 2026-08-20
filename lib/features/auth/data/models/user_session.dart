import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'approval_status.dart';
import 'user_role.dart';

part 'user_session.g.dart';

/// The persisted authentication session (tokens + identity flags).
///
/// Stored in secure storage as a single JSON blob. [access] is the short-lived
/// JWT; [refresh] is the long-lived token used to obtain new access tokens.
@JsonSerializable()
class UserSession extends Equatable {
  const UserSession({
    required this.access,
    this.refresh,
    required this.role,
    required this.approvalStatus,
    this.email,
  });

  final String access;
  final String? refresh;

  @UserRoleConverter()
  final UserRole role;

  @ApprovalStatusConverter()
  final ApprovalStatus approvalStatus;

  final String? email;

  bool get isPendingInstructor =>
      role == UserRole.instructor && approvalStatus == ApprovalStatus.pending;

  bool get isAuthenticated => access.isNotEmpty;

  UserSession copyWith({
    String? access,
    String? refresh,
    UserRole? role,
    ApprovalStatus? approvalStatus,
    String? email,
  }) {
    return UserSession(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
      role: role ?? this.role,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      email: email ?? this.email,
    );
  }

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);

  Map<String, dynamic> toJson() => _$UserSessionToJson(this);

  @override
  List<Object?> get props => [access, refresh, role, approvalStatus, email];
}
