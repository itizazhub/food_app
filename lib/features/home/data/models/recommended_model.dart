import 'package:food_app/features/home/domain/entities/recommended.dart';

class RecommendedModel {
  RecommendedModel({required this.recommendedId, required this.productId});
  String recommendedId;
  String productId;

  factory RecommendedModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return RecommendedModel(
      recommendedId: key,
      productId: json["product_id"],
    );
  }
  factory RecommendedModel.fromEntity({required Recommended recommended}) {
    return RecommendedModel(
      recommendedId: recommended.recommendedId,
      productId: recommended.productId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
    };
  }

  Recommended toEntity() {
    return Recommended(
      recommendedId: recommendedId,
      productId: productId,
    );
  }
}
