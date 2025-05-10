import 'dart:convert';

import 'package:food_app/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserFirebaseDatasource {
  Future<List<UserModel>> getUsers() async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "users.json");
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("login get request status code ${response.statusCode}");

        // Decode the response body and map it to TaskModel
        Map<String, dynamic> result = jsonDecode(response.body);

        return result.entries.map((jsonUser) {
          return UserModel.fromJson(jsonUser.key, jsonUser.value);
        }).toList();
      } else {
        print("login get request error status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("login get request Something bad happened $e");
      return [];
    }
  }
}
