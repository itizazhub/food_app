class CartItem {
  final String productId;
  final int quantity;
  final double price;
  final String imageUrl;
  final String productName;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.productName,
  });

  CartItem copyWith({
    String? productId,
    int? quantity,
    double? price,
    String? imageUrl,
    String? productName,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      productName: productName ?? this.productName,
    );
  }
}
