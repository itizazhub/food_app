import 'dart:convert';
import 'package:food_app/features/home/data/models/recommended_model.dart';
import 'package:http/http.dart' as http;

class RecommendedFirebasedatasource {
  Future<List<RecommendedModel>> getRecommendeds() async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "recommended.json");
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get Recommended  request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);

        return result.entries.map((jsonRecommended) {
          return RecommendedModel.fromJson(
              key: jsonRecommended.key, json: jsonRecommended.value);
        }).toList();
      } else {
        print(
            "Get Recommended request error status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Get Recommended request Something bad happened $e");
      return [];
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
