import 'package:coach_space/features/student/profile/data/models/payment_intent_dto.dart';

/// Contract for `POST /api/payments/intent`.
abstract class PaymentRepository {
  Future<PaymentIntentDto> createIntent({
    required int orderId,
    String? provider,
  });
}
