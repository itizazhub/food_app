class Rating {
  Rating({
    required this.ratingId,
    required this.productId,
    required this.userId,
    required this.rating,
  });
  String ratingId;
  String productId;
  double rating;
  String userId;

  Rating copyWith(
      {String? ratingId, String? productId, double? rating, String? userId}) {
    return Rating(
      ratingId: ratingId ?? this.ratingId,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
    );
  }
}
