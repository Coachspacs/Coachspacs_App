import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/core/networking/api_json_converters.dart';

part 'preferences_dto.g.dart';

/// `GET/PATCH /api/users/me/preferences` response body.
///
/// Holds both the learning settings and the notification/app preferences so a
/// single endpoint backs both settings screens.
@JsonSerializable()
class PreferencesDto {
  const PreferencesDto({
    this.learningGoal = '',
    this.fieldOfInterest = '',
    this.certificateName = '',
    this.playbackSpeed = '1.0',
    this.publicProfile = true,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.language = 'en',
    this.theme = 'light',
  });

  @JsonKey(name: 'learning_goal')
  final String learningGoal;
  @JsonKey(name: 'field_of_interest')
  final String fieldOfInterest;
  @JsonKey(name: 'certificate_name')
  final String certificateName;
  @JsonKey(name: 'playback_speed')
  final String playbackSpeed;
  @JsonKey(name: 'public_profile', fromJson: boolFromJson)
  final bool publicProfile;
  @JsonKey(name: 'email_notifications', fromJson: boolFromJson)
  final bool emailNotifications;
  @JsonKey(name: 'push_notifications', fromJson: boolFromJson)
  final bool pushNotifications;
  final String language;
  final String theme;

  factory PreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$PreferencesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesDtoToJson(this);
}

/// `PATCH /api/users/me/preferences` request body. All fields optional so the
/// learning and preference screens can each patch only what they own.
///
/// `includeIfNull: false` keeps the payload sparse: DRF treats missing keys as
/// "leave unchanged", while explicit `null` could clear stored values.
@JsonSerializable(includeIfNull: false)
class UpdatePreferencesRequest {
  const UpdatePreferencesRequest({
    this.learningGoal,
    this.fieldOfInterest,
    this.certificateName,
    this.playbackSpeed,
    this.publicProfile,
    this.emailNotifications,
    this.pushNotifications,
    this.language,
    this.theme,
  });

  @JsonKey(name: 'learning_goal')
  final String? learningGoal;
  @JsonKey(name: 'field_of_interest')
  final String? fieldOfInterest;
  @JsonKey(name: 'certificate_name')
  final String? certificateName;
  @JsonKey(name: 'playback_speed')
  final String? playbackSpeed;
  @JsonKey(name: 'public_profile')
  final bool? publicProfile;
  @JsonKey(name: 'email_notifications')
  final bool? emailNotifications;
  @JsonKey(name: 'push_notifications')
  final bool? pushNotifications;
  final String? language;
  final String? theme;

  factory UpdatePreferencesRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePreferencesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePreferencesRequestToJson(this);
}
