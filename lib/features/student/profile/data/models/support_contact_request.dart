import 'package:json_annotation/json_annotation.dart';

part 'support_contact_request.g.dart';

/// `POST /api/support/contact` request body.
@JsonSerializable()
class SupportContactRequest {
  const SupportContactRequest({
    required this.message,
    this.subject = '',
    this.category = '',
  });

  final String message;
  final String subject;
  final String category;

  factory SupportContactRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportContactRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SupportContactRequestToJson(this);
}
