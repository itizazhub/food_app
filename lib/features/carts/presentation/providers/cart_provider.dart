import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/data/datasources/cart_firebasedatasource.dart';
import 'package:food_app/features/carts/data/repositories/cart_repository_impl.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/carts/domain/usecases/get_user_cart.dart';
import 'package:food_app/features/carts/domain/usecases/update_user_cart.dart';

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
    result.fold((failure) => print('Get cart failed: ${failure.message}'),
        (cart) {
      state = cart;
      updateTotal();
    });
  }

  Future<void> updateUserCart() async {
    if (state != null) {
      final result = await updateUserCartUseCase(cart: state!);
      result.fold(
        (failure) => print('Update cart failed: ${failure.message}'),
        (message) {
          print(message);
          updateTotal();
        },
      );
    }
  }

  void addItemToCart({
    required CartItem cartItem,
    required int maxQuantity,
  }) {
    if (state == null) return;

    final existingItemIndex = state!.items.indexWhere(
      (item) => item.productId == cartItem.productId,
    );

    if (existingItemIndex != -1) {
      increaseItemQuantity(cartItem.productId, maxQuantity);
    } else {
      final updatedItems = [...state!.items, cartItem];
      state = state!.copyWith(items: updatedItems);
      updateTotal();
    }

    updateUserCart();
  }

  void removeItemFromCart({required CartItem cartItem}) {
    if (state == null) return;

    final updatedItems = state!.items
        .where((item) => item.productId != cartItem.productId)
        .toList();

    state = state!.copyWith(items: updatedItems);
    updateUserCart();
  }

  void updateTotal() {
    if (state == null) return;

    final total = state!.items.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    state = state!.copyWith(total: total);
  }

  void increaseItemQuantity(String productId, int maxQuantity) {
    if (state == null) return;

    final updatedItems = state!.items.map((item) {
      if (item.productId == productId) {
        final newQuantity = item.quantity + 1;
        if (newQuantity <= maxQuantity) {
          return item.copyWith(quantity: newQuantity);
        }
      }
      return item;
    }).toList();

    state = state!.copyWith(items: updatedItems);
    updateTotal();
    updateUserCart();
  }

  void decreaseItemQuantity(String productId) {
    if (state == null) return;

    final updatedItems = state!.items.map((item) {
      if (item.productId == productId) {
        final newQuantity = item.quantity - 1;
        if (newQuantity >= 1) {
          return item.copyWith(quantity: newQuantity);
        }
      }
      return item;
    }).toList();

    state = state!.copyWith(items: updatedItems);
    updateTotal();
    updateUserCart();
  }

  void clearCart() {
    state?.items = [];
    updateTotal();
    updateUserCart();
  }

  void initCartItems({required List<CartItem> cartItems}) {
    state?.items = cartItems;
    updateTotal();
    updateUserCart();
  }
}
