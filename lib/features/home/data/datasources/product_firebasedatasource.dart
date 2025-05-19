import 'dart:convert';
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

        // Decode the response body and map it to TaskModel
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

  Future<void> createUser(UserModel user) async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "users.json");

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(user.toJson()));

      // Correcting the status code check
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Post user created successfully ${response.statusCode}");
      } else {
        print("Post create user error happened ${response.statusCode}");
      }
    } catch (e) {
      print("Post create user Something bad happened $e");
    }
  }
}
