import 'package:json_annotation/json_annotation.dart';

part 'confirm_email_change_request.g.dart';

/// `POST /api/users/me/email/confirm` request body.
///
/// Anonymous: `{uid, token}` from the emailed link.
@JsonSerializable()
class ConfirmEmailChangeRequest {
  const ConfirmEmailChangeRequest({required this.uid, required this.token});

  final String uid;
  final String token;

  factory ConfirmEmailChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailChangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailChangeRequestToJson(this);
}
