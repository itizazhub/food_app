import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/home/data/models/favorite_model.dart';

class FavoriteFirebasedatasource {
  Future<List<FavoriteModel>> getUserFavorite({required User user}) async {
    String userId = user.id;
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "favorites.json",
      {
        "orderBy": '"user_id"',
        "equalTo": '"${user.id}"',
      },
    );

    print("this is user id in fav get ${user.id}");
    try {
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Get fav request status code ${response.statusCode}");

        Map<String, dynamic> result = jsonDecode(response.body);
        print("result of fav: $result");
        return result.entries.map((favoriteJson) {
          return FavoriteModel.fromJson(
              key: favoriteJson.key, json: favoriteJson.value);
        }).toList();
      } else {
        print("Get fav request error status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Get fav request Something bad happened $e");
      return [];
    }
  }

  Future<String> addUserFavorite(FavoriteModel favorite) async {
    final url = Uri.https(
        "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
        "favorites.json");

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(favorite.toJson(favoriteModel: favorite)));

      // Correcting the status code check
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Post user created successfully ${response.statusCode}");
        final result = jsonDecode(response.body);
        return result["name"];
      } else {
        print("Post create user error happened ${response.statusCode}");
        return "";
      }
    } catch (e) {
      print("Post create user Something bad happened $e");
      return "";
    }
  }

  Future<void> removeUserFavorite(FavoriteModel favorite) async {
    final url = Uri.https(
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app",
      "favorites/${favorite.favoriteId}.json",
    );
    print("this is the id of fav ${favorite.favoriteId}");

    try {
      final response = await http.delete(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Favorite deleted successfully: ${response.statusCode}");
      } else {
        print("Failed to delete favorite. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error deleting favorite: $e");
    }
  }
}
