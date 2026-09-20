import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository.dart';

part 'learning_settings_state.dart';

class LearningSettingsCubit extends Cubit<LearningSettingsState> {
  LearningSettingsCubit(PreferencesRepository repository)
      : _repository = repository,
        super(const LearningSettingsInitial());

  final PreferencesRepository _repository;

  PreferencesDto? _prefs;

  Future<void> load() async {
    emit(const LearningSettingsLoading());
    try {
      final prefs = await _repository.getPreferences();
      _prefs = prefs;
      emit(LearningSettingsSuccess(prefs));
    } on NetworkException catch (error) {
      emit(LearningSettingsFailure(error.kind, error.message));
    } catch (_) {
      emit(const LearningSettingsFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  Future<bool> save({
    required String learningGoal,
    required String fieldOfInterest,
    required String certificateName,
    required String playbackSpeed,
    required bool publicProfile,
  }) async {
    final current = _prefs;
    if (current != null) emit(LearningSettingsSaving(current));

    try {
      final updated = await _repository.updatePreferences(
        learningGoal: learningGoal,
        fieldOfInterest: fieldOfInterest,
        certificateName: certificateName,
        playbackSpeed: playbackSpeed,
        publicProfile: publicProfile,
      );
      _prefs = updated;
      emit(LearningSettingsSaved(updated));
      return true;
    } on NetworkException catch (error) {
      emit(LearningSettingsFailure(error.kind, error.message));
      return false;
    } catch (_) {
      emit(const LearningSettingsFailure(FailureKind.unknown, _fallbackMessage));
      return false;
    }
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
