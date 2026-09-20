part of 'notifications_cubit.dart';

sealed class NotificationsState {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

final class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

final class NotificationsSuccess extends NotificationsState {
  const NotificationsSuccess(this.notifications);

  final List<NotificationDto> notifications;
}

final class NotificationsEmpty extends NotificationsState {
  const NotificationsEmpty();
}

final class NotificationsFailure extends NotificationsState {
  const NotificationsFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
