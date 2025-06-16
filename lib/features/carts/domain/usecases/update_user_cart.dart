import 'package:dartz/dartz.dart';
import 'package:food_app/features/cart/domain/entities/cart.dart';
import 'package:food_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:food_app/features/core/error/failures.dart';

class UpdateUserCart {
  UpdateUserCart({required this.cartRepository});
  CartRepository cartRepository;

  Future<Either<Failure, String>> call({required Cart cart}) {
    return cartRepository.updateUserCart(cart: cart);
  }
}
