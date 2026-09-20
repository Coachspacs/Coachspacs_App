import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_dto.g.dart';

/// `POST /api/payments/intent` response body.
@JsonSerializable()
class PaymentIntentDto {
  const PaymentIntentDto({
    required this.id,
    required this.orderId,
    required this.provider,
    required this.status,
    required this.amount,
    required this.currency,
    this.clientSecret,
    this.publishableKey,
  });

  final int id;
  @JsonKey(name: 'order_id')
  final int orderId;
  final String provider;
  final String status;
  final String amount;
  final String currency;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'publishable_key')
  final String? publishableKey;

  /// True when the backend already settled the payment (manual provider).
  bool get isSucceeded => status == 'succeeded';

  factory PaymentIntentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentDtoToJson(this);
}

/// `POST /api/payments/intent` request body.
@JsonSerializable()
class CreatePaymentIntentRequest {
  const CreatePaymentIntentRequest({
    required this.orderId,
    this.provider,
  });

  @JsonKey(name: 'order_id')
  final int orderId;

  /// `manual` (default), `stripe` or `paymob`.
  final String? provider;

  factory CreatePaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentIntentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePaymentIntentRequestToJson(this);
}
