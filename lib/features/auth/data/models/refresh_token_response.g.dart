// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponse _$RefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponse(
  access: json['access'] as String,
  refresh: json['refresh'] as String?,
);

Map<String, dynamic> _$RefreshTokenResponseToJson(
  RefreshTokenResponse instance,
) => <String, dynamic>{'access': instance.access, 'refresh': instance.refresh};
