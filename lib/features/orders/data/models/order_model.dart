import 'package:food_app/features/carts/data/models/cart_item_model.dart';
import 'package:food_app/features/core/date_functions/parse_formatted_date.dart';
import 'package:food_app/features/orders/domain/entities/order.dart';

class OrderModel {
  OrderModel(
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
  List<CartItemModel> items;
  double total;
  String orderType;
  String paymentMethodId;
  String orderStatus;
  String addressId;

  factory OrderModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return OrderModel(
        addressId: json["address_id"],
        items: json['items'] != null
            ? (json['items'] as List)
                .map((item) => CartItemModel.fromJson(item))
                .toList()
            : [],
        orderDate: parseFormattedDate(json["order_date"]),
        orderId: key,
        orderStatus: json["order_status"] ?? "nill",
        orderType: json["order_type"] ?? "nill",
        paymentMethodId: json["payment_method_id"] ?? "nill",
        total: (json["total"] != null)
            ? double.tryParse(json["total"].toString()) ?? 0.0
            : 0.0,
        userId: json["user_id"]);
  }

  factory OrderModel.fromEntity({required Order order}) {
    return OrderModel(
        addressId: order.addressId,
        items: order.items.map((cartItem) {
          return CartItemModel.fromEntity(cartItem: cartItem);
        }).toList(),
        orderDate: order.orderDate,
        orderId: order.orderId,
        orderStatus: order.orderStatus,
        orderType: order.orderType,
        paymentMethodId: order.paymentMethodId,
        total: order.total,
        userId: order.userId);
  }

  Order toEntity() {
    return Order(
        addressId: addressId,
        items: items.map((cartItemModel) {
          return cartItemModel.toEnity();
        }).toList(),
        orderDate: orderDate,
        orderId: orderId,
        orderStatus: orderStatus,
        orderType: orderType,
        paymentMethodId: paymentMethodId,
        total: total,
        userId: userId);
  }

  Map<String, dynamic> toJson() {
    return {
      "address_id": addressId,
      "items": items.map((cartItemModel) {
        return cartItemModel.toJson();
      }).toList(),
      "order_date": orderDate.toString(),
      "order_status": orderStatus,
      "order_type": orderType,
      "payment_method_id": paymentMethodId,
      "total": total,
      "user_id": userId,
    };
  }

  OrderModel copyWith({
    String? orderId,
    DateTime? orderDate,
    String? userId,
    List<CartItemModel>? items,
    double? total,
    String? orderType,
    String? paymentMethodId,
    String? orderStatus,
    String? addressId,
  }) {
    return OrderModel(
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
