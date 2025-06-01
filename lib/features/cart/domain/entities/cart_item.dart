class CartItem {
  final String productId;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({String? productId, int? quantity, double? price}) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
