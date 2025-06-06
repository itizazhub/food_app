import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/orders/data/models/order_model.dart';
import 'package:food_app/features/orders/domain/entities/order.dart'
    as food_app;
import 'package:http/http.dart' as http;

class OrderFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Future<Either<Failure, OrderModel>> addOrder(
      {required food_app.Order order}) async {
    final url = Uri.https(_baseUrl, "orders.json");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(OrderModel.fromEntity(order: order).toJson()),
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        final newOrderId = responseBody['name'];
        return Right(
            OrderModel.fromEntity(order: order).copyWith(orderId: newOrderId));
      } else {
        return Left(SomeSpecificError(
            "Failed to add new order: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in addOrder: ${e.toString()}"));
    }
  }

  Future<Either<Failure, List<OrderModel>>> getUserOrders(
      {required User user}) async {
    final url = Uri.https(
      _baseUrl,
      "orders.json",
      {
        "orderBy": '"user_id"',
        "equalTo": '"${user.id}"',
      },
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        print(result);
        return Right(result.entries
            .map((orderJson) =>
                OrderModel.fromJson(key: orderJson.key, json: orderJson.value))
            .toList());
      } else {
        return Left(
            SomeSpecificError("Failed to fetch cart: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception in getUserCart: ${e.toString()}"));
    }
  }
}
