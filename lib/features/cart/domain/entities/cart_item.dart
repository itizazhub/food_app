class CartItem {
  final String productId;
  final int quantity;

  CartItem({required this.productId, required this.quantity});

  CartItem copyWith({String? productId, int? quantity}) {
    return CartItem(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity);
  }
}
