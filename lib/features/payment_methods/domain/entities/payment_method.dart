class PaymentMethod {
  PaymentMethod({required this.paymentId, required this.payment});
  String paymentId;
  String payment;

  PaymentMethod coypwith({String? paymentId, String? payment}) {
    return PaymentMethod(
        paymentId: paymentId ?? this.paymentId,
        payment: payment ?? this.payment);
  }
}
