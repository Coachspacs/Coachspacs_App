import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';

import 'preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  PreferencesRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<PreferencesDto> getPreferences() => _guard(() => _api.getPreferences());

  @override
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
  }) => _guard(
    () => _api.updatePreferences(
      UpdatePreferencesRequest(
        learningGoal: learningGoal,
        fieldOfInterest: fieldOfInterest,
        certificateName: certificateName,
        playbackSpeed: playbackSpeed,
        publicProfile: publicProfile,
        emailNotifications: emailNotifications,
        pushNotifications: pushNotifications,
        language: language,
        theme: theme,
      ),
    ),
  );

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
