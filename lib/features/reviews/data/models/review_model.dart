import 'package:food_app/features/reviews/domain/entities/review.dart';

class ReviewModel {
  ReviewModel({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.review,
  });
  String reviewId;
  String productId;
  String review;
  String userId;

  factory ReviewModel.fromJson({
    required String key,
    required Map<String, dynamic> json,
  }) {
    return ReviewModel(
      reviewId: key,
      productId: json["product_id"],
      userId: json["user_id"],
      review: json["review"],
    );
  }

  factory ReviewModel.fromEntity({required Review review}) {
    return ReviewModel(
        reviewId: review.reviewId,
        productId: review.productId,
        userId: review.userId,
        review: review.review);
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "user_id": userId,
      "review": review,
    };
  }

  Review toEntity() {
    return Review(
        reviewId: reviewId,
        productId: productId,
        userId: userId,
        review: review);
  }

  ReviewModel copyWith({
    String? reviewId,
    String? productId,
    String? review,
    String? userId,
  }) {
    return ReviewModel(
      reviewId: reviewId ?? this.reviewId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      review: review ?? this.review,
    );
  }
}
