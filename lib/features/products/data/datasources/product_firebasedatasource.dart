import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  final _headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    final url = Uri.https(
      _baseUrl,
      "products.json",
    );

    try {
      final response = await http.get(
        url,
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries
            .map((jsonProduct) => ProductModel.fromJson(
                key: jsonProduct.key, json: jsonProduct.value))
            .toList());
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch product: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception: $e"));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
      {required String categoryId}) async {
    final url = Uri.https(
      _baseUrl,
      "products.json",
      {
        "orderBy": '"category_id"',
        "equalTo": '"$categoryId"',
      },
    );

    try {
      final response = await http.get(
        url,
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get product by category success: ${response.statusCode}");
        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries.map((productJson) {
          return ProductModel.fromJson(
              key: productJson.key, json: productJson.value);
        }).toList());
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch product: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception: $e"));
    }
  }
}

  // Future<void> createUser(UserModel user) async {
  //   final url = Uri.https(
  //       "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
  //       "users.json");

  //   try {
  //     final response = await http.post(url,
  //         headers: {"Content-Type": "application/json"},
  //         body: json.encode(user.toJson()));

  //     // Correcting the status code check
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       print("Post user created successfully ${response.statusCode}");
  //     } else {
  //       print("Post create user error happened ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Post create user Something bad happened $e");
  //   }
  // }

