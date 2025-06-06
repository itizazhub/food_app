import 'package:food_app/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/orders/domain/entities/order.dart'
    as food_app;

class GetUserOrders {
  GetUserOrders({required this.orderRepository});
  OrderRepository orderRepository;
  Future<Either<Failure, List<food_app.Order>>> call({required User user}) {
    return orderRepository.getUserOrders(user: user);
  }
}
