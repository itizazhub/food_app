import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/cart/data/datasources/cart_firebasedatasource.dart';
import 'package:food_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:food_app/features/cart/domain/entities/cart.dart';
import 'package:food_app/features/cart/domain/entities/cart_item.dart';
import 'package:food_app/features/cart/domain/usecases/get_user_cart.dart';
import 'package:food_app/features/cart/domain/usecases/update_user_cart.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';

final cartFirebasedatasource = Provider<CartFirebasedatasource>((ref) {
  return CartFirebasedatasource();
});

final cartRepository = Provider<CartRepositoryImpl>((ref) {
  return CartRepositoryImpl(
      cartFirebasedatasource: ref.read(cartFirebasedatasource));
});

final getUserCartProvider = Provider<GetUserCart>((ref) {
  return GetUserCart(cartRepository: ref.read(cartRepository));
});

final updateUserCartProvider = Provider<UpdateUserCart>((ref) {
  return UpdateUserCart(cartRepository: ref.read(cartRepository));
});

final cartNotifierProvider = StateNotifierProvider<CartNotifier, Cart?>((ref) {
  final getUserCart = ref.read(getUserCartProvider);
  final updateUserCart = ref.read(updateUserCartProvider);

  return CartNotifier(
      getUserCartUseCase: getUserCart, updateUserCartUseCase: updateUserCart);
});

class CartNotifier extends StateNotifier<Cart?> {
  final UpdateUserCart updateUserCartUseCase;
  final GetUserCart getUserCartUseCase;

  CartNotifier({
    required this.getUserCartUseCase,
    required this.updateUserCartUseCase,
  }) : super(null);

  Future<void> getUserCart({required User user}) async {
    final result = await getUserCartUseCase(user: user);
    result.fold(
      (failure) => print('Get cart failed: $failure'),
      (cart) => state = cart,
    );
  }

  Future<void> updateUserCart() async {
    if (state != null) {
      final result = await updateUserCartUseCase(cart: state!);
      result.fold(
        (failure) => print('Update cart failed: $failure'),
        (message) => print(message),
      );
    }
  }

  void addItemToCart({required CartItem cartItem}) {
    if (state == null) return;

    final existingItems = List<CartItem>.from(state!.items);
    existingItems.add(cartItem);

    state = state!.copyWith(items: existingItems);
  }

  void removeItemFromCart({required CartItem cartItem}) {
    if (state == null) return;

    final updatedItems = state!.items
        .where((item) => item.productId != cartItem.productId)
        .toList();

    state = state!.copyWith(items: updatedItems);
  }
}
