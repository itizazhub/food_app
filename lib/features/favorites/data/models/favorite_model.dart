import 'package:food_app/features/favorites/domain/entities/favorite.dart';

class FavoriteModel {
  FavoriteModel(
      {required this.favoriteId,
      required this.productId,
      required this.userId});
  String favoriteId;
  String productId;
  String userId;

  factory FavoriteModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return FavoriteModel(
        favoriteId: key,
        productId: json["product_id"],
        userId: json["user_id"]);
  }

  factory FavoriteModel.fromEntity({required Favorite favorite}) {
    return FavoriteModel(
        favoriteId: favorite.favoriteId,
        productId: favorite.productId,
        userId: favorite.userId);
  }

  Map<String, dynamic> toJson() {
    return {"product_id": productId, "user_id": userId};
  }

  Favorite toEntity() {
    return Favorite(
        favoriteId: favoriteId, productId: productId, userId: userId);
  }

  FavoriteModel copyWith(
      {String? favoriteId, String? productId, String? userId}) {
    return FavoriteModel(
        favoriteId: favoriteId ?? this.favoriteId,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId);
  }
}
