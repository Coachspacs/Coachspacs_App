import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';
import 'package:coach_space/features/student/notifications/data/repo/notifications_repository.dart';
import 'package:coach_space/features/student/notifications/logic/cubit/notifications_cubit.dart';

NotificationDto _notification(int id, {bool isRead = false}) =>
    NotificationDto(
      id: id,
      title: 'Notification $id',
      message: 'Body $id',
      type: 'system',
      isRead: isRead,
      createdAt: DateTime(2026, 1, 4),
    );

class _FakeNotificationsRepository implements NotificationsRepository {
  PaginatedResponse<NotificationDto> page = const PaginatedResponse(
    count: 0,
    results: [],
  );
  Object? listError;
  Object? markReadError;
  Object? markAllReadError;

  final List<int> readIds = [];
  int markAllReadCalls = 0;

  @override
  Future<PaginatedResponse<NotificationDto>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) async {
    if (listError != null) throw listError!;
    return this.page;
  }

  @override
  Future<void> markRead(int id) async {
    readIds.add(id);
    if (markReadError != null) throw markReadError!;
  }

  @override
  Future<void> markAllRead() async {
    markAllReadCalls++;
    if (markAllReadError != null) throw markAllReadError!;
  }
}

void main() {
  late _FakeNotificationsRepository repository;
  late NotificationsCubit cubit;

  setUp(() {
    repository = _FakeNotificationsRepository();
    cubit = NotificationsCubit(repository);
  });

  tearDown(() => cubit.close());

  group('NotificationsCubit.load', () {
    test('emits Loading then Success with the notifications', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [
          _notification(1),
          _notification(2, isRead: true),
        ],
      );
      final emissions = <NotificationsState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [
        isA<NotificationsLoading>(),
        isA<NotificationsSuccess>(),
      ]);
      expect((cubit.state as NotificationsSuccess).notifications, hasLength(2));

      await subscription.cancel();
    });

    test('emits NotificationsEmpty when there are no notifications', () async {
      await cubit.load();

      expect(cubit.state, isA<NotificationsEmpty>());
    });

    test('emits NotificationsFailure with kind and message on error', () async {
      repository.listError = const NetworkException(
        kind: FailureKind.forbidden,
        message: 'Not allowed',
      );

      await cubit.load();

      expect(cubit.state, isA<NotificationsFailure>());
      final failure = cubit.state as NotificationsFailure;
      expect(failure.kind, FailureKind.forbidden);
      expect(failure.message, 'Not allowed');
    });
  });

  group('NotificationsCubit.markRead', () {
    test('updates the item optimistically and calls the repository', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [_notification(1), _notification(2)],
      );
      await cubit.load();

      final future = cubit.markRead(1);

      final optimistic = cubit.state as NotificationsSuccess;
      expect(optimistic.notifications.first.isRead, isTrue);
      expect(optimistic.notifications.last.isRead, isFalse);

      await future;

      expect(repository.readIds, [1]);
      expect(
        (cubit.state as NotificationsSuccess).notifications.first.isRead,
        isTrue,
      );
    });

    test('reverts the optimistic update when the request fails', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [_notification(1), _notification(2)],
      );
      repository.markReadError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'boom',
      );
      await cubit.load();

      await cubit.markRead(1);

      final state = cubit.state as NotificationsSuccess;
      expect(state.notifications.first.isRead, isFalse);
      expect(repository.readIds, [1]);
    });
  });

  group('NotificationsCubit.markAllRead', () {
    test('marks every notification read and returns true', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [_notification(1), _notification(2)],
      );
      await cubit.load();

      final result = await cubit.markAllRead();

      expect(result, isTrue);
      expect(repository.markAllReadCalls, 1);
      final state = cubit.state as NotificationsSuccess;
      expect(state.notifications.every((item) => item.isRead), isTrue);
    });

    test('returns true without calling the repository when all are read', () async {
      repository.page = PaginatedResponse(
        count: 1,
        results: [_notification(1, isRead: true)],
      );
      await cubit.load();

      final result = await cubit.markAllRead();

      expect(result, isTrue);
      expect(repository.markAllReadCalls, 0);
    });

    test('reverts every read flag and returns false on failure', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [_notification(1), _notification(2, isRead: true)],
      );
      repository.markAllReadError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'boom',
      );
      await cubit.load();

      final result = await cubit.markAllRead();

      expect(result, isFalse);
      final state = cubit.state as NotificationsSuccess;
      expect(state.notifications.map((item) => item.isRead), [false, true]);
    });

    test('returns false when there is nothing loaded', () async {
      expect(await cubit.markAllRead(), isFalse);
      expect(repository.markAllReadCalls, 0);
    });
  });
}
