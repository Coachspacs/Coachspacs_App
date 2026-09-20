// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesDto _$PreferencesDtoFromJson(Map<String, dynamic> json) =>
    PreferencesDto(
      learningGoal: json['learning_goal'] as String? ?? '',
      fieldOfInterest: json['field_of_interest'] as String? ?? '',
      certificateName: json['certificate_name'] as String? ?? '',
      playbackSpeed: json['playback_speed'] as String? ?? '1.0',
      publicProfile: json['public_profile'] == null
          ? true
          : boolFromJson(json['public_profile']),
      emailNotifications: json['email_notifications'] == null
          ? true
          : boolFromJson(json['email_notifications']),
      pushNotifications: json['push_notifications'] == null
          ? true
          : boolFromJson(json['push_notifications']),
      language: json['language'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'light',
    );

Map<String, dynamic> _$PreferencesDtoToJson(PreferencesDto instance) =>
    <String, dynamic>{
      'learning_goal': instance.learningGoal,
      'field_of_interest': instance.fieldOfInterest,
      'certificate_name': instance.certificateName,
      'playback_speed': instance.playbackSpeed,
      'public_profile': instance.publicProfile,
      'email_notifications': instance.emailNotifications,
      'push_notifications': instance.pushNotifications,
      'language': instance.language,
      'theme': instance.theme,
    };

UpdatePreferencesRequest _$UpdatePreferencesRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePreferencesRequest(
  learningGoal: json['learning_goal'] as String?,
  fieldOfInterest: json['field_of_interest'] as String?,
  certificateName: json['certificate_name'] as String?,
  playbackSpeed: json['playback_speed'] as String?,
  publicProfile: json['public_profile'] as bool?,
  emailNotifications: json['email_notifications'] as bool?,
  pushNotifications: json['push_notifications'] as bool?,
  language: json['language'] as String?,
  theme: json['theme'] as String?,
);

Map<String, dynamic> _$UpdatePreferencesRequestToJson(
  UpdatePreferencesRequest instance,
) => <String, dynamic>{
  'learning_goal': ?instance.learningGoal,
  'field_of_interest': ?instance.fieldOfInterest,
  'certificate_name': ?instance.certificateName,
  'playback_speed': ?instance.playbackSpeed,
  'public_profile': ?instance.publicProfile,
  'email_notifications': ?instance.emailNotifications,
  'push_notifications': ?instance.pushNotifications,
  'language': ?instance.language,
  'theme': ?instance.theme,
};
