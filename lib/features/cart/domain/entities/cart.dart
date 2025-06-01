import 'package:food_app/features/cart/domain/entities/cart_item.dart';

class Cart {
  Cart(
      {required this.cartId,
      required this.items,
      required this.userId,
      required this.total});
  String cartId;
  List<CartItem> items;
  String userId;
  double total;

  Cart copyWith(
      {String? cartId, List<CartItem>? items, String? userId, double? total}) {
    return Cart(
        cartId: cartId ?? this.cartId,
        items: items ?? this.items,
        userId: userId ?? this.userId,
        total: total ?? this.total);
  }
}
