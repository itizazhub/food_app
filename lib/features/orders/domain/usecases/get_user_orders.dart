import 'package:food_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

class GetUserOrders {
  GetUserOrders({required this.orderRepository});
  OrderRepository orderRepository;
  Future<Either<Failure, List<Order>>> call({required User user}) {
    return orderRepository.getUserOrders(user: user);
  }
}
