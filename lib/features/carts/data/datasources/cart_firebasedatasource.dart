import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/carts/data/models/cart_item_model.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:http/http.dart' as http;

import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/data/models/cart_model.dart';
import 'package:food_app/features/core/error/failures.dart';

class CartFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";

  Future<Either<Failure, CartModel>> getUserCart({required User user}) async {
    final url = Uri.https(
      _baseUrl,
      "carts.json",
      {
        "orderBy": '"user_id"',
        "equalTo": '"${user.id}"',
      },
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body) as Map<String, dynamic>?;
        print(result);
        if (result != null && result.isNotEmpty) {
          final firstEntry = result.entries.first;
          return Right(
            CartModel.fromJson(key: firstEntry.key, json: firstEntry.value),
          );
        }

        // No cart found → create a new one
        return await _createNewCart(user);
      } else {
        return Left(
            SomeSpecificError("Failed to fetch cart: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception in getUserCart: ${e.toString()}"));
    }
  }

  Future<Either<Failure, String>> updateCart({
    required Cart cart,
  }) async {
    final url = Uri.https(_baseUrl, "carts/${cart.cartId}.json");

    try {
      final response = await http.patch(
        url,
        body: jsonEncode({
          "items": cart.items
              .map((item) => CartItemModel.fromEntity(cartItem: item).toJson())
              .toList(),
        }),
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const Right("Cart items updated successfully");
      } else {
        return Left(SomeSpecificError(
            "Failed to update items: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in updateCartItemsOnly: $e"));
    }
  }

  Future<Either<Failure, CartModel>> _createNewCart(User user) async {
    final newCart = CartModel(
      cartId: '',
      items: [],
      userId: user.id,
      total: 0.0,
    );

    final url = Uri.https(_baseUrl, "carts.json");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(newCart.toJson()),
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        final newCartId = responseBody['name'];
        return Right(newCart.copyWith(cartId: newCartId));
      } else {
        return Left(SomeSpecificError(
            "Failed to create new cart: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Exception in createNewCart: ${e.toString()}"));
    }
  }

  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };
}
