import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/payment_methods/data/datasources/payment_methods_firebasedatasource.dart';
import 'package:food_app/features/payment_methods/data/repositories/payment_methods_repository_impl.dart';
import 'package:food_app/features/payment_methods/domain/entities/payment_method.dart';
import 'package:food_app/features/payment_methods/domain/usecases/get_payment_methods.dart';

final paymentMethodsFirebasedatasourceProvider =
    Provider<PaymentMethodsFirebasedatasource>((ref) {
  return PaymentMethodsFirebasedatasource();
});

final paymentMethodsRepositoryImpProvider =
    Provider<PaymentMethodsRepositoryImpl>((ref) {
  return PaymentMethodsRepositoryImpl(
      paymentMethodsFirebasedatasource:
          ref.watch(paymentMethodsFirebasedatasourceProvider));
});

final getPaymentMethodsProvider = Provider<GetPaymentMethods>((ref) {
  return GetPaymentMethods(
      paymentMethodRepository: ref.watch(paymentMethodsRepositoryImpProvider));
});

final paymentMethodsNotifierProvider =
    StateNotifierProvider<PaymentMethodsNotifier, List<PaymentMethod>>((ref) {
  final getPaymentMethods = ref.watch(getPaymentMethodsProvider);
  return PaymentMethodsNotifier(getPaymentMethodsUseCase: getPaymentMethods);
});

class PaymentMethodsNotifier extends StateNotifier<List<PaymentMethod>> {
  PaymentMethodsNotifier({required this.getPaymentMethodsUseCase}) : super([]);
  final GetPaymentMethods getPaymentMethodsUseCase;

  Future<void> getPaymentMethods() async {
    final failureOrPaymentMethods = await getPaymentMethodsUseCase();
    failureOrPaymentMethods.fold(
      (failure) => print(failure.message),
      (paymentMethods) => state = paymentMethods,
    );
  }
}
