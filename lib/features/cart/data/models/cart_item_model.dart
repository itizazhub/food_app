import 'package:food_app/features/cart/domain/entities/cart_item.dart';

class CartItemModel {
  final String productId;
  final int quantity;
  final double price;

  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      quantity: int.parse(json['quantity']),
      price: double.parse(json["price"]),
    );
  }

  factory CartItemModel.fromEntity({required CartItem cartItem}) {
    return CartItemModel(
        productId: cartItem.productId,
        quantity: cartItem.quantity,
        price: cartItem.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }

  CartItem toEnity() {
    return CartItem(productId: productId, quantity: quantity, price: price);
  }

  CartItemModel copyWith({String? productId, int? quantity, double? price}) {
    return CartItemModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
