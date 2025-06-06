import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getUserOrders({required User user});
  Future<Either<Failure, Order>> addOrder({required Order order});
}
