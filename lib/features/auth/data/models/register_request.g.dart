// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: const UserRoleConverter().fromJson(json['role'] as String),
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'role': const UserRoleConverter().toJson(instance.role),
    };
