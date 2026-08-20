// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSession _$UserSessionFromJson(Map<String, dynamic> json) => UserSession(
  access: json['access'] as String,
  refresh: json['refresh'] as String?,
  role: const UserRoleConverter().fromJson(json['role'] as String),
  approvalStatus: const ApprovalStatusConverter().fromJson(
    json['approvalStatus'] as String,
  ),
  email: json['email'] as String?,
);

Map<String, dynamic> _$UserSessionToJson(UserSession instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'role': const UserRoleConverter().toJson(instance.role),
      'approvalStatus': const ApprovalStatusConverter().toJson(
        instance.approvalStatus,
      ),
      'email': instance.email,
    };
