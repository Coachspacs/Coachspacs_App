import 'package:json_annotation/json_annotation.dart';

part 'resend_verification_request.g.dart';

/// `POST /api/auth/verify-email/resend` request body.
@JsonSerializable()
class ResendVerificationRequest {
  const ResendVerificationRequest({required this.email});

  final String email;

  factory ResendVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendVerificationRequestToJson(this);
}
