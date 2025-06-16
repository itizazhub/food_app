import 'package:dartz/dartz.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:food_app/features/carts/domain/repositories/cart_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class GetUserCart {
  GetUserCart({required this.cartRepository});
  CartRepository cartRepository;

  Future<Either<Failure, Cart>> call({required User user}) {
    return cartRepository.getUserCart(user: user);
  }
}
