import 'package:food_app/features/payment_methods/domain/entities/payment_method.dart';

class PaymentMethodModel {
  PaymentMethodModel({required this.paymentId, required this.payment});
  String paymentId;
  String payment;

  factory PaymentMethodModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return PaymentMethodModel(paymentId: key, payment: json["name"]);
  }

  factory PaymentMethodModel.fromEntity(
      {required PaymentMethod paymentMethod}) {
    return PaymentMethodModel(
        paymentId: paymentMethod.paymentId, payment: paymentMethod.payment);
  }
  PaymentMethod toEntity() {
    return PaymentMethod(paymentId: paymentId, payment: payment);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": payment,
    };
  }

  PaymentMethodModel coypwith({String? paymentId, String? payment}) {
    return PaymentMethodModel(
        paymentId: paymentId ?? this.paymentId,
        payment: payment ?? this.payment);
  }
}
