import 'package:food_app/features/products/domain/entities/product.dart';

class ProductModel {
  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.productName,
    required this.stockQuantity,
    required this.rating,
  });
  String productId;
  String categoryId;
  String description;
  String imageUrl;
  double price;
  String productName;
  int stockQuantity;
  double rating;

  factory ProductModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return ProductModel(
      productId: key,
      categoryId: json["category_id"],
      description: json["description"],
      imageUrl: json["image_url"],
      price: (json["price"] is String)
          ? double.tryParse(json["price"]) ?? 0.0
          : (json["price"] as num).toDouble(),
      productName: json["product_name"],
      stockQuantity: int.tryParse(json["stock_quantity"].toString()) ?? 0,
      rating: (json["rating"] is String)
          ? double.tryParse(json["rating"]) ?? 0.0
          : (json["rating"] as num).toDouble(),
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
      rating: product.rating,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "category_id": categoryId,
      "description": description,
      "image_url": imageUrl,
      "price": price,
      "product_name": productName,
      "stock_quantity": stockQuantity,
      "rating": rating,
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
      rating: rating,
    );
  }
}
