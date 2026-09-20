import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';

import 'notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({required ApiService apiService})
    : _api = apiService;

  final ApiService _api;

  @override
  Future<PaginatedResponse<NotificationDto>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) => _guard(() => _api.getNotifications(page: page, pageSize: pageSize));

  @override
  Future<void> markRead(int id) => _guard(() => _api.markNotificationRead(id));

  @override
  Future<void> markAllRead() => _guard(() => _api.markAllNotificationsRead());

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
