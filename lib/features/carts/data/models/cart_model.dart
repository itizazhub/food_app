import 'package:food_app/features/carts/data/models/cart_item_model.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';

class CartModel {
  CartModel(
      {required this.cartId,
      required this.items,
      required this.userId,
      required this.total});
  String cartId;
  List<CartItemModel> items;
  String userId;
  double total;

  factory CartModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return CartModel(
      cartId: key,
      items: json['items'] != null
          ? (json['items'] as List)
              .map((item) => CartItemModel.fromJson(item))
              .toList()
          : [],
      userId: json["user_id"],
      total: (json["total"] != null)
          ? double.tryParse(json["total"].toString()) ?? 0.0
          : 0.0,
    );
  }

  factory CartModel.fromEntity({required Cart cart}) {
    return CartModel(
        cartId: cart.cartId,
        items: cart.items.map((cartItem) {
          return CartItemModel.fromEntity(cartItem: cartItem);
        }).toList(),
        userId: cart.userId,
        total: cart.total);
  }

  Cart toEntity() {
    return Cart(
        cartId: cartId,
        items: items.map((cartItemModel) {
          return cartItemModel.toEnity();
        }).toList(),
        userId: userId,
        total: total);
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((cartItemModel) {
        return cartItemModel.toJson();
      }).toList(),
      "user_id": userId,
      "total": total
    };
  }

  CartModel copyWith(
      {String? cartId,
      List<CartItemModel>? items,
      String? userId,
      double? total}) {
    return CartModel(
        cartId: cartId ?? this.cartId,
        items: items ?? this.items,
        userId: userId ?? this.userId,
        total: total ?? this.total);
  }
}
