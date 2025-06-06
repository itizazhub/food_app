import 'package:food_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:food_app/features/core/error/failures.dart';

class AddOrder {
  AddOrder({required this.orderRepository});
  OrderRepository orderRepository;
  Future<Either<Failure, Order>> call({required Order order}) {
    return orderRepository.addOrder(order: order);
  }
}
