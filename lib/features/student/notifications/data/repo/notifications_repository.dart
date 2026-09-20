import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';

/// Contract for `GET /api/notifications` endpoints.
abstract class NotificationsRepository {
  Future<PaginatedResponse<NotificationDto>> getNotifications({
    int page = 1,
    int pageSize = 20,
  });

  Future<void> markRead(int id);

  Future<void> markAllRead();
}
