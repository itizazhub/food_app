class Favorite {
  Favorite(
      {required this.favoriteId,
      required this.productId,
      required this.userId});
  String favoriteId;
  String productId;
  String userId;

  Favorite copyWith({String? favoriteId, String? productId, String? userId}) {
    return Favorite(
        favoriteId: favoriteId ?? this.favoriteId,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId);
  }
}
