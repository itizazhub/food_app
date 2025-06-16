import 'package:food_app/features/ratings/domain/entities/rating.dart';

class RatingModel {
  RatingModel({
    required this.ratingId,
    required this.productId,
    required this.userId,
    required this.rating,
  });
  String ratingId;
  String productId;
  double rating;
  String userId;

  factory RatingModel.fromJson({
    required String key,
    required Map<String, dynamic> json,
  }) {
    return RatingModel(
      ratingId: key,
      productId: json["product_id"],
      userId: json["user_id"],
      rating: json["rating"],
    );
  }

  factory RatingModel.fromEntity({required Rating rating}) {
    return RatingModel(
        ratingId: rating.ratingId,
        productId: rating.productId,
        userId: rating.userId,
        rating: rating.rating);
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "user_id": userId,
      "rating": rating,
    };
  }

  Rating toEntity() {
    return Rating(
        ratingId: ratingId,
        productId: productId,
        userId: userId,
        rating: rating);
  }

  RatingModel copyWith({
    String? ratingId,
    String? productId,
    double? rating,
    String? userId,
  }) {
    return RatingModel(
      ratingId: ratingId ?? this.ratingId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
    );
  }
}
