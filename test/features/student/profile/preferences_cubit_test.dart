import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/preferences_cubit.dart';

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
  late PreferencesCubit cubit;

  const prefs = PreferencesDto(
    emailNotifications: true,
    pushNotifications: true,
    language: 'en',
    theme: 'light',
  );

  setUp(() {
    repository = _FakePreferencesRepository();
    cubit = PreferencesCubit(repository);
  });

  tearDown(() => cubit.close());

  group('PreferencesCubit.load', () {
    test('emits Loading then Success with the preferences', () async {
      repository.prefs = prefs;
      final emissions = <PreferencesState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<PreferencesLoading>(), isA<PreferencesSuccess>()]);
      expect((cubit.state as PreferencesSuccess).prefs.language, 'en');

      await subscription.cancel();
    });

    test('emits PreferencesFailure with kind and message on error', () async {
      repository.getError = const NetworkException(
        kind: FailureKind.unauthorized,
        message: 'Login again',
      );

      await cubit.load();

      expect(cubit.state, isA<PreferencesFailure>());
      final failure = cubit.state as PreferencesFailure;
      expect(failure.kind, FailureKind.unauthorized);
      expect(failure.message, 'Login again');
    });
  });

  group('PreferencesCubit.save', () {
    test('forwards the fields, emits Saved and returns true', () async {
      repository.prefs = prefs;
      repository.updated = const PreferencesDto(
        emailNotifications: false,
        pushNotifications: true,
        language: 'ar',
        theme: 'dark',
      );
      await cubit.load();
      final emissions = <PreferencesState>[];
      final subscription = cubit.stream.listen(emissions.add);

      final result = await cubit.save(
        emailNotifications: false,
        pushNotifications: true,
        language: 'ar',
        theme: 'dark',
      );
      await Future<void>.delayed(Duration.zero);

      expect(result, isTrue);
      expect(emissions, [isA<PreferencesSaving>(), isA<PreferencesSaved>()]);
      final call = repository.lastUpdate!;
      expect(call.emailNotifications, isFalse);
      expect(call.pushNotifications, isTrue);
      expect(call.language, 'ar');
      expect(call.theme, 'dark');
      expect(
        (cubit.state as PreferencesSaved).prefs.language,
        'ar',
      );

      await subscription.cancel();
    });

    test('emits PreferencesFailure and returns false on error', () async {
      repository.prefs = prefs;
      repository.updateError = const NetworkException(
        kind: FailureKind.validation,
        message: 'Invalid language',
      );
      await cubit.load();

      final result = await cubit.save(
        emailNotifications: true,
        pushNotifications: true,
        language: 'xx',
        theme: 'light',
      );

      expect(result, isFalse);
      expect(cubit.state, isA<PreferencesFailure>());
      expect((cubit.state as PreferencesFailure).message, 'Invalid language');
    });
  });
}
