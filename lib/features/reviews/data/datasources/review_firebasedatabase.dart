import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/reviews/data/models/review_model.dart';
import 'package:food_app/features/reviews/domain/entities/review.dart';
import 'package:http/http.dart' as http;

class ReviewFirebasedatabase {
  final _baseUrl =
      "food-app-35ca7-default-rtdb.asia-southeast1.firebasedatabase.app";
  Map<String, String> get _headers => {
        "Content-Type": "application/json",
      };

  Future<Either<Failure, ReviewModel>> addReview(
      {required Review review}) async {
    final url = Uri.https(_baseUrl, "reviews.json");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(ReviewModel.fromEntity(review: review).toJson()),
        headers: _headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        final newreviewId = responseBody['name'];
        return Right(ReviewModel.fromEntity(review: review)
            .copyWith(reviewId: newreviewId));
      } else {
        return Left(SomeSpecificError(
            "Failed to add new review: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in addreview: ${e.toString()}"));
    }
  }

  Future<Either<Failure, List<ReviewModel>>> getReviews(
      {required Product product}) async {
    final url = Uri.https(
      _baseUrl,
      "reviews.json",
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

        return Right(result.entries
            .map((reviewJson) => ReviewModel.fromJson(
                key: reviewJson.key, json: reviewJson.value))
            .toList());
      } else {
        return Left(SomeSpecificError(
            "Failed to fetch reviews: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(SomeSpecificError("Exception in getreview: ${e.toString()}"));
    }
  }
}
