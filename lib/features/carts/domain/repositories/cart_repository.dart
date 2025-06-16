import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:food_app/features/core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getUserCart({required User user});
  Future<Either<Failure, String>> updateUserCart({required Cart cart});
}
