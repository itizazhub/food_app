import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';

class CartButton extends ConsumerWidget {
  final Product product;
  final User user;

  const CartButton({
    super.key,
    required this.product,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final notifier = ref.read(cartNotifierProvider.notifier);

    final isInCart = cartState.cart?.items
            .any((item) => item.productId == product.productId) ??
        false;
    final isLoading = cartState.loadingIds.contains(product.productId);

    return InkWell(
      onTap: isLoading
          ? null
          : () {
              final cartItem = CartItem(
                productId: product.productId,
                productName: product.productName,
                price: product.price,
                quantity: 1,
                imageUrl: product.imageUrl,
              );

              if (isInCart) {
                notifier.removeItemFromCart(cartItem: cartItem);
              } else {
                notifier.addItemToCart(cartItem: cartItem, maxQuantity: 10);
              }
            },
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.orangeLight,
              foregroundColor: Colors.white,
              child: Icon(
                  isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                  size: 14,
                  color: AppColors.orangeDark),
            ),
    );
  }
}
