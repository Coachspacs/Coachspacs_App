import 'package:json_annotation/json_annotation.dart';

part 'logout_request.g.dart';

/// `POST /api/auth/logout` request body.
@JsonSerializable()
class LogoutRequest {
  const LogoutRequest({required this.refresh});

  final String refresh;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}
