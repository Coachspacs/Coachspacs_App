import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/support_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/contact_cubit.dart';

typedef _ContactCall = ({
  String message,
  String subject,
  String category,
});

class _FakeSupportRepository implements SupportRepository {
  Object? error;
  _ContactCall? lastCall;

  @override
  Future<void> sendContactMessage({
    required String message,
    String subject = '',
    String category = '',
  }) async {
    lastCall = (message: message, subject: subject, category: category);
    if (error != null) throw error!;
  }
}

void main() {
  late _FakeSupportRepository repository;
  late ContactCubit cubit;

  setUp(() {
    repository = _FakeSupportRepository();
    cubit = ContactCubit(repository);
  });

  tearDown(() => cubit.close());

  test('send emits Sending then Sent and returns true', () async {
    final emissions = <ContactState>[];
    final subscription = cubit.stream.listen(emissions.add);

    final result = await cubit.send(
      message: 'I need help',
      subject: 'Billing',
      category: 'payment',
    );
    await Future<void>.delayed(Duration.zero);

    expect(result, isTrue);
    expect(emissions, [isA<ContactSending>(), isA<ContactSent>()]);
    expect(repository.lastCall?.message, 'I need help');
    expect(repository.lastCall?.subject, 'Billing');
    expect(repository.lastCall?.category, 'payment');

    await subscription.cancel();
  });

  test('send emits ContactFailure with kind and returns false', () async {
    repository.error = const NetworkException(
      kind: FailureKind.rateLimited,
      message: 'Too many messages',
    );

    final result = await cubit.send(
      message: 'I need help',
      subject: 'Billing',
      category: 'payment',
    );

    expect(result, isFalse);
    expect(cubit.state, isA<ContactFailure>());
    final failure = cubit.state as ContactFailure;
    expect(failure.kind, FailureKind.rateLimited);
    expect(failure.message, 'Too many messages');
  });
}
