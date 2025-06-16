import 'package:food_app/features/carts/domain/entities/cart_item.dart';

class CartItemModel {
  final String productId;
  final int quantity;
  final double price;
  final String imageUrl;
  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        productId: json['product_id'],
        quantity: (json["quantity"] != null)
            ? int.tryParse(json["quantity"].toString()) ?? 0
            : 0,
        price: (json["price"] != null)
            ? double.tryParse(json["price"].toString()) ?? 0.0
            : 0.0,
        imageUrl: json["image_url"]);
  }

  factory CartItemModel.fromEntity({required CartItem cartItem}) {
    return CartItemModel(
      productId: cartItem.productId,
      quantity: cartItem.quantity,
      price: cartItem.price,
      imageUrl: cartItem.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'image_url': imageUrl,
      'price': price,
    };
  }

  CartItem toEnity() {
    return CartItem(
        productId: productId,
        quantity: quantity,
        price: price,
        imageUrl: imageUrl);
  }

  CartItemModel copyWith(
      {String? productId, int? quantity, double? price, String? imageUrl}) {
    return CartItemModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
