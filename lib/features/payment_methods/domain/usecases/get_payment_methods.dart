import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/payment_methods/domain/entities/payment_method.dart';
import 'package:food_app/features/payment_methods/domain/repositories/payment_method_repository.dart';

class GetPaymentMethods {
  GetPaymentMethods({required this.paymentMethodRepository});
  PaymentMethodRepository paymentMethodRepository;

  Future<Either<Failure, List<PaymentMethod>>> call() {
    return paymentMethodRepository.getPaymentMethods();
  }
}
