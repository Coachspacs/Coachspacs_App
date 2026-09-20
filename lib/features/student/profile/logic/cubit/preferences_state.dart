part of 'preferences_cubit.dart';

sealed class PreferencesState {
  const PreferencesState();
}

final class PreferencesInitial extends PreferencesState {
  const PreferencesInitial();
}

final class PreferencesLoading extends PreferencesState {
  const PreferencesLoading();
}

final class PreferencesSuccess extends PreferencesState {
  const PreferencesSuccess(this.prefs);

  final PreferencesDto prefs;
}

final class PreferencesSaving extends PreferencesState {
  const PreferencesSaving(this.prefs);

  final PreferencesDto prefs;
}

final class PreferencesSaved extends PreferencesState {
  const PreferencesSaved(this.prefs);

  final PreferencesDto prefs;
}

final class PreferencesFailure extends PreferencesState {
  const PreferencesFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
