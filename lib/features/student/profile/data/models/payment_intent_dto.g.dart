// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentDto _$PaymentIntentDtoFromJson(Map<String, dynamic> json) =>
    PaymentIntentDto(
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      provider: json['provider'] as String,
      status: json['status'] as String,
      amount: json['amount'] as String,
      currency: json['currency'] as String,
      clientSecret: json['client_secret'] as String?,
      publishableKey: json['publishable_key'] as String?,
    );

Map<String, dynamic> _$PaymentIntentDtoToJson(PaymentIntentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'provider': instance.provider,
      'status': instance.status,
      'amount': instance.amount,
      'currency': instance.currency,
      'client_secret': instance.clientSecret,
      'publishable_key': instance.publishableKey,
    };

CreatePaymentIntentRequest _$CreatePaymentIntentRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentIntentRequest(
  orderId: (json['order_id'] as num).toInt(),
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$CreatePaymentIntentRequestToJson(
  CreatePaymentIntentRequest instance,
) => <String, dynamic>{
  'order_id': instance.orderId,
  'provider': instance.provider,
};
