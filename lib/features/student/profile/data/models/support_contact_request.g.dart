// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_contact_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportContactRequest _$SupportContactRequestFromJson(
  Map<String, dynamic> json,
) => SupportContactRequest(
  message: json['message'] as String,
  subject: json['subject'] as String? ?? '',
  category: json['category'] as String? ?? '',
);

Map<String, dynamic> _$SupportContactRequestToJson(
  SupportContactRequest instance,
) => <String, dynamic>{
  'message': instance.message,
  'subject': instance.subject,
  'category': instance.category,
};
