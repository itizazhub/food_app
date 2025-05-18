import 'package:food_app/features/home/domain/entities/product.dart';

class ProductModel {
  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.productName,
    required this.stockQuantity,
  });
  String productId;
  String categoryId;
  String description;
  String imageUrl;
  double price;
  String productName;
  String stockQuantity;

  factory ProductModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return ProductModel(
      productId: key,
      categoryId: json["categoryId"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      price: json["price"],
      productName: json["productName"],
      stockQuantity: json["stockQuantity"],
    );
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      productId: product.productId,
      categoryId: product.categoryId,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      productName: product.productName,
      stockQuantity: product.stockQuantity,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "description": description,
      "imageUrl": imageUrl,
      "price": price,
      "productName": productName,
      "stockQuantity": stockQuantity,
    };
  }

  Product toEntity() {
    return Product(
      productId: productId,
      categoryId: categoryId,
      description: description,
      imageUrl: imageUrl,
      price: price,
      productName: productName,
      stockQuantity: stockQuantity,
    );
  }
}
