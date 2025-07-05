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

  Map<String, dynamic> toJson({required FavoriteModel favoriteModel}) {
    return {
      "product_id": favoriteModel.productId,
      "user_id": favoriteModel.userId
    };
  }

  Favorite toEntity({required FavoriteModel favoriteModel}) {
    return Favorite(
        favoriteId: favoriteModel.favoriteId,
        productId: favoriteModel.productId,
        userId: favoriteModel.userId);
  }
}
