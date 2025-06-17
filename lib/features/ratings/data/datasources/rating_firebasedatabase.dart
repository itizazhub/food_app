import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/ratings/data/models/rating_model.dart';
import 'package:food_app/features/ratings/domain/entities/rating.dart';
import 'package:http/http.dart' as http;

class RatingFirebasedatabase {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Future<Either<Failure, RatingModel>> addRating(
      {required Rating rating}) async {
    final url = Uri.https(_baseUrl, "ratings.json");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(RatingModel.fromEntity(rating: rating).toJson()),
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        final newRatingId = responseBody['name'];
        return Right(RatingModel.fromEntity(rating: rating)
            .copyWith(ratingId: newRatingId));
      } else {
        return Left(SomeSpecificError(
            "Failed to add new rating: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in addRating: ${e.toString()}"));
    }
  }

  Future<Either<Failure, double>> getRating({required Product product}) async {
    final url = Uri.https(
      _baseUrl,
      "ratings.json",
      {
        "orderBy": '"product_id"',
        "equalTo": '"${product.productId}"',
      },
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        print(result);
        if (result.isEmpty) {
          return Right(0.0);
        }
        final ratings = result.entries
            .map((ratingJson) => RatingModel.fromJson(
                key: ratingJson.key, json: ratingJson.value))
            .toList();
        final total = ratings.fold<double>(
          0.0,
          (sum, rating) => sum + rating.rating,
        );

        final average = total / ratings.length;
        return Right(average);
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch ratings: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in getRating: ${e.toString()}"));
    }
  }
}
