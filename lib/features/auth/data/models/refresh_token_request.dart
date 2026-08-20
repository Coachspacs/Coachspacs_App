import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

/// `POST /api/auth/refresh` request body.
@JsonSerializable()
class RefreshTokenRequest {
  const RefreshTokenRequest({required this.refresh});

  final String refresh;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
