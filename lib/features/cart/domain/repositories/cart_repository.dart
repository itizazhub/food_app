import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<void> createUserCart({required User user}) async {}
  Future<void> getUserCart({required User user}) async {}

  Future<void> resetUserCart({required Cart cart}) async {}
  Future<void> saveUserCart({required Cart cart}) async {}
}
