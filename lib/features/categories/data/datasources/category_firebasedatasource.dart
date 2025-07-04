import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/categories/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";

  final _headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    final url = Uri.https(_baseUrl, "categories.json");
    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get categories request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        return Right(result.entries.map((jsonCategory) {
          return CategoryModel.fromJson(
              key: jsonCategory.key, json: jsonCategory.value);
        }).toList());
      } else {
        return Left(SomeSpecificError(
            "Get users request error status code ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Get users request Something bad happened $e"));
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
