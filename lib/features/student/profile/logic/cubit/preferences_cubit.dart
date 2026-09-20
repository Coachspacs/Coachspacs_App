import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(PreferencesRepository repository)
      : _repository = repository,
        super(const PreferencesInitial());

  final PreferencesRepository _repository;

  PreferencesDto? _prefs;

  Future<void> load() async {
    emit(const PreferencesLoading());
    try {
      final prefs = await _repository.getPreferences();
      _prefs = prefs;
      emit(PreferencesSuccess(prefs));
    } on NetworkException catch (error) {
      emit(PreferencesFailure(error.kind, error.message));
    } catch (_) {
      emit(const PreferencesFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  Future<bool> save({
    required bool emailNotifications,
    required bool pushNotifications,
    required String language,
    required String theme,
  }) async {
    final current = _prefs;
    if (current != null) emit(PreferencesSaving(current));

    try {
      final updated = await _repository.updatePreferences(
        emailNotifications: emailNotifications,
        pushNotifications: pushNotifications,
        language: language,
        theme: theme,
      );
      _prefs = updated;
      emit(PreferencesSaved(updated));
      return true;
    } on NetworkException catch (error) {
      emit(PreferencesFailure(error.kind, error.message));
      return false;
    } catch (_) {
      emit(const PreferencesFailure(FailureKind.unknown, _fallbackMessage));
      return false;
    }
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
