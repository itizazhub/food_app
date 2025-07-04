import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductFirebasedatasource {
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required List<String> keys,
  }) async {
    List<ProductModel> products = [];
    List<String> errorMessages = [];
    for (String key in keys) {
      final productOrFailure = await getProduct(key: key);
      productOrFailure.fold(
        (failure) {
          errorMessages.add("[$key] ${failure.message}");
        },
        (product) {
          products.add(product);
        },
      );
    }
    if (errorMessages.isNotEmpty) {
      final errorString = errorMessages.join('\n');
      return Left(
          SomeSpecificError("Failed to fetch some products:\n$errorString"));
    }

    return Right(products);
  }

  Future<Either<Failure, ProductModel>> getProduct({
    required String key,
  }) async {
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "products/$key.json",
    );

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get product $key success: ${response.statusCode}");
        final result = jsonDecode(response.body);

        return Right(ProductModel.fromJson(key: key, json: result));
      } else {
        print("Get product $key failed: ${response.statusCode}");
        return Left(SomeSpecificError(
            "Failed to fetch product: ${response.statusCode}"));
      }
    } catch (e) {
      print("Exception while fetching product $key: $e");
      return Left(SomeSpecificError("Exception: $e"));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
      {required String categoryId}) async {
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "products.json",
      {
        "orderBy": '"category_id"',
        "equalTo": '"$categoryId"',
      },
    );

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get product by category success: ${response.statusCode}");
        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries.map((productJson) {
          return ProductModel.fromJson(
              key: productJson.key, json: productJson.value);
        }).toList());
      } else {
        print("Get product by category failed: ${response.statusCode}");
        return Left(SomeSpecificError(
            "Failed to fetch product: ${response.statusCode}"));
      }
    } catch (e) {
      print("Exception while fetching product by category: $e");
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

