import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/payment_methods/data/models/payment_method_model.dart';
import 'package:http/http.dart' as http;

class PaymentMethodsFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Future<Either<Failure, List<PaymentMethodModel>>> getPaymentMethods() async {
    final url = Uri.https(
      _baseUrl,
      "payment_methods.json",
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        return Right(result.entries
            .map((paymentMethodModelJson) => PaymentMethodModel.fromJson(
                key: paymentMethodModelJson.key,
                json: paymentMethodModelJson.value))
            .toList());
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch payment methods: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception in getPaymentMethods: ${e.toString()}"));
    }
  }
}
