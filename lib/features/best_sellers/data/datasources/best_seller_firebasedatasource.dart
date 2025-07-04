import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/best_sellers/data/models/best_seller_model.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class BestSellerFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";

  final _headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<ProductModel>>> getBestSellerProducts() async {
    final url = Uri.https(_baseUrl, "products.json");
    try {
      final failureOrBestSellersIds = await getBestSellerProductIds();
      return failureOrBestSellersIds.fold((failure) => Left(failure),
          (bestSellersIds) async {
        final response = await http.get(url, headers: _headers);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          print("Get best sellers request status code ${response.statusCode}");

          Map<String, dynamic> result = jsonDecode(response.body);

          return Right(result.entries
              .where((id) => bestSellersIds.contains(id.key))
              .map((jsonProduct) => ProductModel.fromJson(
                  key: jsonProduct.key, json: jsonProduct.value))
              .toList());
        } else {
          return Left(SomeSpecificError(
              "Get best sellers request error status code ${response.statusCode}"));
        }
      });
    } catch (e) {
      return Left(SomeSpecificError(
          "Get best sellers request Something bad happened $e"));
    }
  }

  Future<Either<Failure, List<String>>> getBestSellerProductIds() async {
    final url = Uri.https(_baseUrl, "best_seller.json");
    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get best sellers request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries.map((jsonBestSeller) {
          return BestSellerModel.fromJson(
                  key: jsonBestSeller.key, json: jsonBestSeller.value)
              .productId;
        }).toList());
      } else {
        return Left(SomeSpecificError(
            "Get best sellers request error status code ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError(
          "Get best sellers request Something bad happened $e"));
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
