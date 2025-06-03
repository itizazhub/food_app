class CartItem {
  final String productId;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.productId,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  CartItem copyWith(
      {String? productId, int? quantity, double? price, String? imageUrl}) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
