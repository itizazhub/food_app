import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/favorites/data/models/favorite_model.dart';

class FavoriteFirebasedatasource {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  final _headers = {"Content-Type": "application/json"};

  Future<Either<Failure, List<FavoriteModel>>> getUserFavorite(
      {required User user}) async {
    final url = Uri.https(
      _baseUrl,
      "favorites.json",
      {
        "orderBy": '"user_id"',
        "equalTo": '"${user.id}"',
      },
    );
    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> result = jsonDecode(response.body);
        return Right(result.entries.map((favoriteJson) {
          return FavoriteModel.fromJson(
              key: favoriteJson.key, json: favoriteJson.value);
        }).toList());
      } else {
        return Left(SomeSpecificError(
            "Get fav request error status code ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Get fav request Something bad happened $e"));
    }
  }

  Future<Either<Failure, FavoriteModel>> addUserFavorite(
      {required Favorite favorite}) async {
    final url = Uri.https(_baseUrl, "favorites.json");

    try {
      final response = await http.post(url,
          headers: _headers,
          body: json
              .encode(FavoriteModel.fromEntity(favorite: favorite).toJson()));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);
        return Right(FavoriteModel.fromEntity(
            favorite: favorite.copyWith(favoriteId: result["name"])));
      } else {
        return Left(SomeSpecificError(
            "Post create user error happened ${response.statusCode}"));
      }
    } catch (e) {
      return Left(
          SomeSpecificError("Post create user Something bad happened $e"));
    }
  }

  Future<Either<Failure, String>> removeUserFavorite(
      {required Favorite favorite}) async {
    final url = Uri.https(
      _baseUrl,
      "favorites/${favorite.favoriteId}.json",
    );
    try {
      final response = await http.delete(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right("Favorite deleted successfully: ${response.statusCode}");
      } else {
        return Left(SomeSpecificError(
            "Failed to delete favorite. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Error deleting favorite: $e"));
    }
  }
}
