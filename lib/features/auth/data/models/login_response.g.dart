// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
      role: const UserRoleConverter().fromJson(json['role'] as String),
      approvalStatus: const ApprovalStatusConverter().fromJson(
        json['approval_status'] as String,
      ),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'role': const UserRoleConverter().toJson(instance.role),
      'approval_status': const ApprovalStatusConverter().toJson(
        instance.approvalStatus,
      ),
    };
