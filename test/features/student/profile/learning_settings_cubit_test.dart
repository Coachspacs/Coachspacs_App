import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/learning_settings_cubit.dart';

typedef _UpdateCall = ({
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

class _FakePreferencesRepository implements PreferencesRepository {
  PreferencesDto? prefs;
  Object? getError;
  Object? updateError;
  PreferencesDto? updated;
  _UpdateCall? lastUpdate;

  @override
  Future<PreferencesDto> getPreferences() async {
    if (getError != null) throw getError!;
    return prefs!;
  }

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
  }) async {
    lastUpdate = (
      learningGoal: learningGoal,
      fieldOfInterest: fieldOfInterest,
      certificateName: certificateName,
      playbackSpeed: playbackSpeed,
      publicProfile: publicProfile,
      emailNotifications: emailNotifications,
      pushNotifications: pushNotifications,
      language: language,
      theme: theme,
    );
    if (updateError != null) throw updateError!;
    return updated!;
  }
}

void main() {
  late _FakePreferencesRepository repository;
  late LearningSettingsCubit cubit;

  const prefs = PreferencesDto(
    learningGoal: 'Career switch',
    fieldOfInterest: 'Development',
    certificateName: 'Jane Doe',
    playbackSpeed: '1.0',
    publicProfile: true,
  );

  setUp(() {
    repository = _FakePreferencesRepository();
    cubit = LearningSettingsCubit(repository);
  });

  tearDown(() => cubit.close());

  group('LearningSettingsCubit.load', () {
    test('emits Loading then Success with the preferences', () async {
      repository.prefs = prefs;
      final emissions = <LearningSettingsState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [
        isA<LearningSettingsLoading>(),
        isA<LearningSettingsSuccess>(),
      ]);
      expect(
        (cubit.state as LearningSettingsSuccess).prefs.learningGoal,
        'Career switch',
      );

      await subscription.cancel();
    });

    test('emits LearningSettingsFailure with kind and message on error', () async {
      repository.getError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'Settings unavailable',
      );

      await cubit.load();

      expect(cubit.state, isA<LearningSettingsFailure>());
      final failure = cubit.state as LearningSettingsFailure;
      expect(failure.kind, FailureKind.serverError);
      expect(failure.message, 'Settings unavailable');
    });
  });

  group('LearningSettingsCubit.save', () {
    test('forwards the fields, emits Saved and returns true', () async {
      repository.prefs = prefs;
      repository.updated = const PreferencesDto(
        learningGoal: 'Promotion',
        fieldOfInterest: 'Design',
        certificateName: 'Jane D.',
        playbackSpeed: '1.5',
        publicProfile: false,
      );
      await cubit.load();
      final emissions = <LearningSettingsState>[];
      final subscription = cubit.stream.listen(emissions.add);

      final result = await cubit.save(
        learningGoal: 'Promotion',
        fieldOfInterest: 'Design',
        certificateName: 'Jane D.',
        playbackSpeed: '1.5',
        publicProfile: false,
      );
      await Future<void>.delayed(Duration.zero);

      expect(result, isTrue);
      expect(emissions, [
        isA<LearningSettingsSaving>(),
        isA<LearningSettingsSaved>(),
      ]);
      final call = repository.lastUpdate!;
      expect(call.learningGoal, 'Promotion');
      expect(call.fieldOfInterest, 'Design');
      expect(call.certificateName, 'Jane D.');
      expect(call.playbackSpeed, '1.5');
      expect(call.publicProfile, isFalse);

      await subscription.cancel();
    });

    test('emits LearningSettingsFailure and returns false on error', () async {
      repository.prefs = prefs;
      repository.updateError = const NetworkException(
        kind: FailureKind.validation,
        message: 'Invalid playback speed',
      );
      await cubit.load();

      final result = await cubit.save(
        learningGoal: 'Promotion',
        fieldOfInterest: 'Design',
        certificateName: 'Jane D.',
        playbackSpeed: '9.9',
        publicProfile: false,
      );

      expect(result, isFalse);
      expect(cubit.state, isA<LearningSettingsFailure>());
      expect(
        (cubit.state as LearningSettingsFailure).message,
        'Invalid playback speed',
      );
    });
  });
}
