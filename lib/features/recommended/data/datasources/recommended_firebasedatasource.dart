import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/data/models/product_model.dart';
import 'package:food_app/features/recommended/data/models/recommended_model.dart';
import 'package:http/http.dart' as http;

class RecommendedFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";

  final _headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<ProductModel>>> getRecommendedProducts() async {
    final url = Uri.https(_baseUrl, "products.json");
    try {
      final failureOrRecommendedsIds = await getRecommendedProductIds();
      return failureOrRecommendedsIds.fold((failure) => Left(failure),
          (recommendedsIds) async {
        final response = await http.get(url, headers: _headers);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          print("Get recommended request status code ${response.statusCode}");

          Map<String, dynamic> result = jsonDecode(response.body);

          return Right(result.entries
              .where((id) => recommendedsIds.contains(id.key))
              .map((jsonProduct) => ProductModel.fromJson(
                  key: jsonProduct.key, json: jsonProduct.value))
              .toList());
        } else {
          return Left(SomeSpecificError(
              "Get recommended request error status code ${response.statusCode}"));
        }
      });
    } catch (e) {
      return Left(SomeSpecificError(
          "Get recommended request Something bad happened $e"));
    }
  }

  Future<Either<Failure, List<String>>> getRecommendedProductIds() async {
    final url = Uri.https(_baseUrl, "recommended.json");
    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get recommended request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries.map((jsonRecommended) {
          return RecommendedModel.fromJson(
                  key: jsonRecommended.key, json: jsonRecommended.value)
              .productId;
        }).toList());
      } else {
        return Left(SomeSpecificError(
            "Get recommended request error status code ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError(
          "Get recommended request Something bad happened $e"));
    }
  }
}

//   Future<void> createUser(UserModel user) async {
//     final url = Uri.https(
//         "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
//         "users.json");

//     try {
//       final response = await http.post(url,
//           headers: {"Content-Type": "application/json"},
//           body: json.encode(user.toJson()));

//       // Correcting the status code check
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         print("Post user created successfully ${response.statusCode}");
//       } else {
//         print("Post create user error happened ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Post create user Something bad happened $e");
//     }
//   }
// }
