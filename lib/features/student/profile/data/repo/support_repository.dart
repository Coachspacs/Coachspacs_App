/// Contract for `POST /api/support/contact`.
abstract class SupportRepository {
  Future<void> sendContactMessage({
    required String message,
    String subject = '',
    String category = '',
  });
}
