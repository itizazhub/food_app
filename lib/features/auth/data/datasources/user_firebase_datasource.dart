import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/features/auth/data/models/user_model.dart';

class UserFirebaseDatasource {
  Future<List<UserModel>> getUsers() async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "users.json");
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get users request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        return result.entries.map((jsonUser) {
          return UserModel.fromJson(jsonUser.key, jsonUser.value);
        }).toList();
      } else {
        print("Get users request error status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Get users request Something bad happened $e");
      return [];
    }
  }

  Future<Either<Failure, UserModel>> createUser(UserModel user) async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "users.json");

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(user.toJson()));

      final result = json.decode(response.body);

      // Correcting the status code check
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Post user created successfully ${response.statusCode}");
        final userOrFailure = await getUser(userId: result["name"]);
        return userOrFailure;
      } else {
        print("Post create user error happened ${response.statusCode}");
        return Left(
            (SomeSpecificError("Can not create user ${response.statusCode}")));
      }
    } catch (e) {
      print("Post create user Something bad happened $e");
      return Left((SomeSpecificError("Can not create user $e")));
    }
  }
}

Future<Either<Failure, UserModel>> getUser({required String userId}) async {
  final url = Uri.https(
    "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
    "users/$userId.json",
  );
  try {
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("Get user request status code ${response.statusCode}");

      Map<String, dynamic> result = jsonDecode(response.body);

      return Right(UserModel.fromJson(userId, result));
    } else {
      print("Get user request error status code ${response.statusCode}");
      return Left(
          (SomeSpecificError("Some error happend ${response.statusCode}")));
    }
  } catch (e) {
    print("Get user request Something bad happened $e");
    return Left(
        (SomeSpecificError("Get user request Something bad happened $e")));
  }
}
