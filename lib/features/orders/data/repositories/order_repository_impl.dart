import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<Either<Failure, Order>> addOrder({required Order order}) {
    // TODO: implement addOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Order>>> getUserOrders({required User user}) {
    // TODO: implement getUserOrders
    throw UnimplementedError();
  }
}
