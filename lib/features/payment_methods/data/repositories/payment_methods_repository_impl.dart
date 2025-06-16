import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/payment_methods/data/datasources/payment_methods_firebasedatasource.dart';
import 'package:food_app/features/payment_methods/domain/entities/payment_method.dart';
import 'package:food_app/features/payment_methods/domain/repositories/payment_method_repository.dart';

class PaymentMethodsRepositoryImpl implements PaymentMethodRepository {
  PaymentMethodsRepositoryImpl(
      {required this.paymentMethodsFirebasedatasource});
  PaymentMethodsFirebasedatasource paymentMethodsFirebasedatasource;

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    try {
      final failureOrPaymentMethods =
          await paymentMethodsFirebasedatasource.getPaymentMethods();
      return failureOrPaymentMethods.fold((failure) {
        return Left(failure);
      }, (paymentMethods) {
        return Right(paymentMethods
            .map((paymentMethod) => paymentMethod.toEntity())
            .toList());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
