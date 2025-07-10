import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/data/datasources/cart_firebasedatasource.dart';
import 'package:food_app/features/carts/data/repositories/cart_repository_impl.dart';
import 'package:food_app/features/carts/domain/entities/cart.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/carts/domain/usecases/get_user_cart.dart';
import 'package:food_app/features/carts/domain/usecases/update_user_cart.dart';
import 'package:food_app/features/core/error/failures.dart';

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

class CartState {
  final Cart? cart;
  final bool isLoading;
  final Failure? failure;
  final Set<String> loadingIds; // For per-item loading

  CartState({
    required this.cart,
    required this.isLoading,
    required this.failure,
    required this.loadingIds,
  });

  factory CartState.initial() => CartState(
        cart: null,
        isLoading: false,
        failure: null,
        loadingIds: {},
      );

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    Failure? failure,
    Set<String>? loadingIds,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      loadingIds: loadingIds ?? this.loadingIds,
    );
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  final getUserCart = ref.read(getUserCartProvider);
  final updateUserCart = ref.read(updateUserCartProvider);
  return CartNotifier(
    getUserCartUseCase: getUserCart,
    updateUserCartUseCase: updateUserCart,
  );
});

class CartNotifier extends StateNotifier<CartState> {
  final UpdateUserCart updateUserCartUseCase;
  final GetUserCart getUserCartUseCase;

  CartNotifier({
    required this.getUserCartUseCase,
    required this.updateUserCartUseCase,
  }) : super(CartState.initial());

  Future<void> getUserCart({required User user}) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await getUserCartUseCase(user: user);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (cart) {
        state = state.copyWith(cart: cart, isLoading: false);
        updateTotal();
      },
    );
  }

  Future<void> updateUserCart() async {
    if (state.cart == null) return;
    final result = await updateUserCartUseCase(cart: state.cart!);
    result.fold(
      (failure) => state = state.copyWith(failure: failure),
      (_) => updateTotal(),
    );
  }

  void addItemToCart({required CartItem cartItem, required int maxQuantity}) {
    if (state.cart == null) return;

    final exists =
        state.cart!.items.any((item) => item.productId == cartItem.productId);

    _updateItemLoading(cartItem.productId, true);
    if (exists) {
      increaseItemQuantity(cartItem.productId, maxQuantity);
    } else {
      final updatedItems = [...state.cart!.items, cartItem];
      state = state.copyWith(cart: state.cart!.copyWith(items: updatedItems));
      updateTotal();
    }
    updateUserCart();
    _updateItemLoading(cartItem.productId, false);
  }

  void removeItemFromCart({required CartItem cartItem}) {
    if (state.cart == null) return;

    _updateItemLoading(cartItem.productId, true);
    final updatedItems = state.cart!.items
        .where((item) => item.productId != cartItem.productId)
        .toList();
    state = state.copyWith(cart: state.cart!.copyWith(items: updatedItems));
    updateTotal();
    updateUserCart();
    _updateItemLoading(cartItem.productId, false);
  }

  void increaseItemQuantity(String productId, int maxQuantity) {
    if (state.cart == null) return;

    final updatedItems = state.cart!.items.map((item) {
      if (item.productId == productId) {
        final newQty = item.quantity + 1;
        if (newQty <= maxQuantity) {
          return item.copyWith(quantity: newQty);
        }
      }
      return item;
    }).toList();

    state = state.copyWith(cart: state.cart!.copyWith(items: updatedItems));
    updateTotal();
    updateUserCart();
  }

  void decreaseItemQuantity(String productId) {
    print("i am here b");
    if (state.cart == null) return;
    print("i am here a");
    final updatedItems = state.cart!.items.map((item) {
      if (item.productId == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    state = state.copyWith(cart: state.cart!.copyWith(items: updatedItems));
    updateTotal();
    updateUserCart();
  }

  void clearCart() {
    if (state.cart == null) return;
    state = state.copyWith(cart: state.cart!.copyWith(items: []));
    updateTotal();
    updateUserCart();
  }

  void updateTotal() {
    if (state.cart == null) return;
    final total = state.cart!.items.fold<double>(
      0.0,
      (sum, item) => sum + item.price * item.quantity,
    );
    state = state.copyWith(cart: state.cart!.copyWith(total: total));
  }

  void _updateItemLoading(String id, bool isLoading) {
    final newIds = {...state.loadingIds};
    isLoading ? newIds.add(id) : newIds.remove(id);
    state = state.copyWith(loadingIds: newIds);
  }
}
