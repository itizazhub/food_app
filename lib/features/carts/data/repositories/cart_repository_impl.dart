import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/data/datasources/cart_firebasedatasource.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:food_app/features/carts/domain/repositories/cart_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.cartFirebasedatasource});
  CartFirebasedatasource cartFirebasedatasource;
  @override
  Future<Either<Failure, Cart>> getUserCart({required User user}) async {
    try {
      final result = await cartFirebasedatasource.getUserCart(user: user);

      return result.fold(
        (failure) => Left(failure),
        (cartModel) =>
            Right(cartModel.toEntity()), // Assuming CartModel extends Cart
      );
    } catch (e) {
      return Left(SomeSpecificError("Exception in getUserCart: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserCart({required Cart cart}) async {
    try {
      final result = await cartFirebasedatasource.updateCart(cart: cart);

      return result.fold(
        (failure) => Left(failure),
        (success) => Right(success),
      );
    } catch (e) {
      return Left(SomeSpecificError("Exception in getUserCart: $e"));
    }
  }
}
