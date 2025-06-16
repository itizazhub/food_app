import 'package:food_app/features/carts/domain/entities/cart_item.dart';

class Order {
  Order(
      {required this.addressId,
      required this.items,
      required this.orderDate,
      required this.orderId,
      required this.orderStatus,
      required this.orderType,
      required this.paymentMethodId,
      required this.total,
      required this.userId});
  String orderId;
  DateTime orderDate;
  String userId;
  List<CartItem> items;
  double total;
  String orderType;
  String paymentMethodId;
  String orderStatus;
  String addressId;

  Order copyWith({
    String? orderId,
    DateTime? orderDate,
    String? userId,
    List<CartItem>? items,
    double? total,
    String? orderType,
    String? paymentMethodId,
    String? orderStatus,
    String? addressId,
  }) {
    return Order(
        addressId: addressId ?? this.addressId,
        items: items ?? this.items,
        orderDate: orderDate ?? this.orderDate,
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus,
        orderType: orderType ?? this.orderType,
        paymentMethodId: paymentMethodId ?? this.paymentMethodId,
        total: total ?? this.total,
        userId: userId ?? this.userId);
  }
}
