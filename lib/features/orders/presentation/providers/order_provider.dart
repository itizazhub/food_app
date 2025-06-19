import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/orders/data/datasources/order_firebasedatasource.dart';
import 'package:food_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:food_app/features/orders/domain/entities/order.dart';
import 'package:food_app/features/orders/domain/usecases/add_order.dart';
import 'package:food_app/features/orders/domain/usecases/get_user_orders.dart';

final orderFirebasedatasourceProvider =
    Provider<OrderFirebasedatasource>((ref) {
  return OrderFirebasedatasource();
});

final orderRepositoryImplProvider = Provider<OrderRepositoryImpl>((ref) {
  return OrderRepositoryImpl(
      orderFirebasedatasource: ref.watch(orderFirebasedatasourceProvider));
});

final getUserOrdersProvider = Provider<GetUserOrders>((ref) {
  return GetUserOrders(orderRepository: ref.watch(orderRepositoryImplProvider));
});

final addOrderProvider = Provider<AddOrder>((ref) {
  return AddOrder(orderRepository: ref.watch(orderRepositoryImplProvider));
});

final orderNotifierProvider =
    StateNotifierProvider<OrderNotifier, List<Order>>((ref) {
  final getUserOrders = ref.watch(getUserOrdersProvider);
  final addOrder = ref.watch(addOrderProvider);
  return OrderNotifier(
      addOrderUseCase: addOrder, getUserOrdersUseCase: getUserOrders);
});

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier(
      {required this.addOrderUseCase, required this.getUserOrdersUseCase})
      : super([]);
  final GetUserOrders getUserOrdersUseCase;
  final AddOrder addOrderUseCase;

  Future<void> getUserOrders({required User user}) async {
    final result = await getUserOrdersUseCase(user: user);
    result.fold(
      (failure) {
        debugPrint("Failed to get addresses: ${failure.message}");
      },
      (orders) {
        state = [...orders];
      },
    );
  }

  Future<void> addOrder({required Order order}) async {
    final result = await addOrderUseCase(order: order);
    result.fold(
      (failure) {
        debugPrint("Failed to get addresses: ${failure.message}");
      },
      (success) {
        debugPrint("Successfully order added: $success");
      },
    );
  }

  Order getOrderById({required String orderId}) {
    final matchedOrder = state.firstWhere((order) {
      return order.orderId == orderId;
    });
    return matchedOrder;
  }

  List<Order> activeOrders() {
    final activeOrdersList = state.where((order) {
      return order.orderStatus == "-OPVnopZWgoqB8b3oK8I";
    }).toList();
    return activeOrdersList;
  }

  List<Order> completedOrders() {
    final completedOrdersList = state.where((order) {
      return order.orderStatus == "-OPVnqE0OKq74KEpQkwj";
    }).toList();
    return completedOrdersList;
  }

  List<Order> cancelledOrders() {
    final cancelledOrdersList = state.where((order) {
      return order.orderStatus == "-OPVnwE0OLQ75KEpQHwl";
    }).toList();
    return cancelledOrdersList;
  }
}
