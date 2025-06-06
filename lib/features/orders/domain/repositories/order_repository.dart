import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/orders/domain/entities/order.dart'
    as food_app;

abstract class OrderRepository {
  Future<Either<Failure, List<food_app.Order>>> getUserOrders(
      {required User user});
  Future<Either<Failure, food_app.Order>> addOrder(
      {required food_app.Order order});
}
