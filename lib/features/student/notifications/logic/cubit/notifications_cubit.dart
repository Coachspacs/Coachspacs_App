import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';
import 'package:coach_space/features/student/notifications/data/repo/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsInitial());

  static const int _pageSize = 20;

  final NotificationsRepository _repository;

  Future<void> load() async {
    emit(const NotificationsLoading());
    try {
      final page = await _repository.getNotifications(
        page: 1,
        pageSize: _pageSize,
      );
      if (isClosed) return;
      final notifications = page.results;
      if (notifications.isEmpty) {
        emit(const NotificationsEmpty());
      } else {
        emit(NotificationsSuccess(notifications));
      }
    } on NetworkException catch (error) {
      if (isClosed) return;
      emit(NotificationsFailure(error.kind, error.message));
    } catch (_) {
      if (isClosed) return;
      emit(const NotificationsFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  /// Marks [id] as read optimistically and reverts if the request fails.
  Future<void> markRead(int id) async {
    final current = state;
    if (current is! NotificationsSuccess) return;

    final index = current.notifications.indexWhere((item) => item.id == id);
    if (index == -1 || current.notifications[index].isRead) return;

    final optimistic = List<NotificationDto>.from(current.notifications);
    optimistic[index] = optimistic[index].copyWith(isRead: true);
    emit(NotificationsSuccess(optimistic));

    try {
      await _repository.markRead(id);
    } catch (_) {
      if (isClosed) return;
      final snapshot = state;
      if (snapshot is! NotificationsSuccess) return;
      final revertIndex = snapshot.notifications.indexWhere(
        (item) => item.id == id,
      );
      if (revertIndex == -1) return;
      final reverted = List<NotificationDto>.from(snapshot.notifications);
      reverted[revertIndex] = reverted[revertIndex].copyWith(isRead: false);
      emit(NotificationsSuccess(reverted));
    }
  }

  /// Marks every notification as read optimistically. Returns `true` on
  /// success and reverts the list when the request fails.
  Future<bool> markAllRead() async {
    final current = state;
    if (current is! NotificationsSuccess) return false;
    if (current.notifications.every((item) => item.isRead)) return true;

    final previous = List<NotificationDto>.from(current.notifications);
    emit(
      NotificationsSuccess(
        previous.map((item) => item.copyWith(isRead: true)).toList(),
      ),
    );

    try {
      await _repository.markAllRead();
      return true;
    } catch (_) {
      if (!isClosed) emit(NotificationsSuccess(previous));
      return false;
    }
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
