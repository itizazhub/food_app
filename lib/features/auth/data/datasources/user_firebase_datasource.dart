import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/features/auth/data/models/user_model.dart';

class UserFirebaseDatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";

  final _headers = {"Content-Type": "application/json"};

  Future<List<UserModel>> getUsers() async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "users.json");
    try {
      final response = await http.get(url, headers: _headers);

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
          headers: _headers, body: json.encode(user.toJson()));

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

  Future<Either<Failure, String>> updateUserPassword(
      {required User user}) async {
    final url = Uri.https(_baseUrl, "users/${user.id}.json");
    try {
      final response = await http.put(url,
          headers: _headers,
          body: json.encode(UserModel.fromEntity(user).toJson()));
      // Correcting the status code check
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(
            "Post user password is updated successfully ${response.statusCode}");

        return const Right("user password is updated successfully");
      } else {
        return Left((SomeSpecificError(
            "Post error in updateUserPassword happened ${response.statusCode}")));
      }
    } catch (e) {
      return Left((SomeSpecificError(
          "Post Something bad is happened updateUserPassword $e")));
    }
  }

  Future<Either<Failure, String>> updateUserProfile(
      {required User user}) async {
    final url = Uri.https(_baseUrl, "users/${user.id}.json");
    List<UserModel> users = await getUsers();
    users.removeWhere((u) => u.id == user.id);
    final userOrNull =
        users.firstWhereOrNull((u) => u.username == user.username);
    if (userOrNull == null) {
      // update user

      try {
        final response = await http.put(url,
            headers: _headers,
            body: json.encode(UserModel.fromEntity(user).toJson()));
        // Correcting the status code check
        if (response.statusCode >= 200 && response.statusCode < 300) {
          print(
              "Post user profile is updated successfully ${response.statusCode}");

          return const Right("user profile is updated successfully");
        } else {
          return Left((SomeSpecificError(
              "Post error in updateUser happened ${response.statusCode}")));
        }
      } catch (e) {
        return Left((SomeSpecificError(
            "Post Something bad is happened updateUser $e")));
      }
    } else {
      return Left(SomeSpecificError(
          "User name is already available please use different user name"));
    }
  }

  Future<Either<Failure, UserModel>> getUser({required String userId}) async {
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "users/$userId.json",
    );
    try {
      final response = await http.get(url, headers: _headers);

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
}
