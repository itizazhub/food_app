class Review {
  Review({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.review,
  });
  String reviewId;
  String productId;
  double review;
  String userId;

  Review copyWith(
      {String? reviewId, String? productId, double? review, String? userId}) {
    return Review(
      reviewId: reviewId ?? this.reviewId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      review: review ?? this.review,
    );
  }
}
