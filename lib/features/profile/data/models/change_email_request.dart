import 'package:json_annotation/json_annotation.dart';

part 'change_email_request.g.dart';

/// `POST /api/users/me/email/change` request body.
@JsonSerializable()
class ChangeEmailRequest {
  const ChangeEmailRequest({required this.newEmail});

  @JsonKey(name: 'new_email')
  final String newEmail;

  factory ChangeEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEmailRequestToJson(this);
}
