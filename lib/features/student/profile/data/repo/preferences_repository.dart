import '../models/preferences_dto.dart';

/// Contract for `GET/PATCH /api/users/me/preferences`.
abstract class PreferencesRepository {
  Future<PreferencesDto> getPreferences();

  Future<PreferencesDto> updatePreferences({
    String? learningGoal,
    String? fieldOfInterest,
    String? certificateName,
    String? playbackSpeed,
    bool? publicProfile,
    bool? emailNotifications,
    bool? pushNotifications,
    String? language,
    String? theme,
  });
}
