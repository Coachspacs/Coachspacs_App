part of 'learning_settings_cubit.dart';

sealed class LearningSettingsState {
  const LearningSettingsState();
}

final class LearningSettingsInitial extends LearningSettingsState {
  const LearningSettingsInitial();
}

final class LearningSettingsLoading extends LearningSettingsState {
  const LearningSettingsLoading();
}

final class LearningSettingsSuccess extends LearningSettingsState {
  const LearningSettingsSuccess(this.prefs);

  final PreferencesDto prefs;
}

final class LearningSettingsSaving extends LearningSettingsState {
  const LearningSettingsSaving(this.prefs);

  final PreferencesDto prefs;
}

final class LearningSettingsSaved extends LearningSettingsState {
  const LearningSettingsSaved(this.prefs);

  final PreferencesDto prefs;
}

final class LearningSettingsFailure extends LearningSettingsState {
  const LearningSettingsFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
