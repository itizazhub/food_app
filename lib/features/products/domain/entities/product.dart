class Product {
  Product({
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

  Product copyWith({
    String? productId,
    String? categoryId,
    String? description,
    String? imageUrl,
    double? price,
    String? productName,
    int? stockQuantity,
    double? rating,
  }) {
    return Product(
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      productName: productName ?? this.productName,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      rating: rating ?? this.rating,
    );
  }
}
