import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response.g.dart';

/// `POST /api/auth/refresh` successful response body.
///
/// [refresh] may be absent when the backend does not rotate the refresh
/// token; in that case the stored refresh token stays in use.
@JsonSerializable()
class RefreshTokenResponse {
  const RefreshTokenResponse({required this.access, this.refresh});

  final String access;
  final String? refresh;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
