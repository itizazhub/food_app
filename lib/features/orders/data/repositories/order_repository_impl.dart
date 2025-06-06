import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/orders/data/datasources/order_firebasedatasource.dart';
import 'package:food_app/features/orders/domain/repositories/order_repository.dart';
import 'package:food_app/features/orders/domain/entities/order.dart'
    as food_app;

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.orderFirebasedatasource});
  OrderFirebasedatasource orderFirebasedatasource;
  @override
  Future<Either<Failure, food_app.Order>> addOrder(
      {required food_app.Order order}) async {
    try {
      final failureOrOrder =
          await orderFirebasedatasource.addOrder(order: order);
      return failureOrOrder.fold((failure) {
        return Left(failure);
      }, (order) {
        return Right(order.toEntity());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<food_app.Order>>> getUserOrders(
      {required User user}) async {
    try {
      final failureOrOrders =
          await orderFirebasedatasource.getUserOrders(user: user);
      return failureOrOrders.fold((failure) {
        return Left(failure);
      }, (orders) {
        return Right(orders.map((address) => address.toEntity()).toList());
      });
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
