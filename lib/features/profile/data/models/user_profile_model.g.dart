// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      role: _$JsonConverterFromJson<String, UserRole>(
        json['role'],
        const UserRoleConverter().fromJson,
      ),
      approvalStatus: _$JsonConverterFromJson<String, ApprovalStatus>(
        json['approval_status'],
        const ApprovalStatusConverter().fromJson,
      ),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'role': _$JsonConverterToJson<String, UserRole>(
        instance.role,
        const UserRoleConverter().toJson,
      ),
      'approval_status': _$JsonConverterToJson<String, ApprovalStatus>(
        instance.approvalStatus,
        const ApprovalStatusConverter().toJson,
      ),
      'avatar': instance.avatar,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
