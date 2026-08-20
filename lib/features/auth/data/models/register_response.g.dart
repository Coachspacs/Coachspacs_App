// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: const UserRoleConverter().fromJson(json['role'] as String),
      fullName: json['full_name'] as String? ?? '',
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': const UserRoleConverter().toJson(instance.role),
      'full_name': instance.fullName,
      'detail': instance.detail,
    };
