import 'package:food_app/features/home/domain/entities/best_seller.dart';

class BestSellerModel {
  BestSellerModel({required this.bestSellerId, required this.productId});
  String bestSellerId;
  String productId;

  factory BestSellerModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return BestSellerModel(bestSellerId: key, productId: json["prodductId"]);
  }
  factory BestSellerModel.fromEntity({required BestSeller bestSeller}) {
    return BestSellerModel(
      bestSellerId: bestSeller.bestSellerId,
      productId: bestSeller.productId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }

  BestSeller toEntity() {
    return BestSeller(
      bestSellerId: bestSellerId,
      productId: productId,
    );
  }
}
