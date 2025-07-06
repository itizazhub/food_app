import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/products/domain/entities/product.dart';

class FavoriteButton extends ConsumerWidget {
  final Product product;
  final User user;

  const FavoriteButton({required this.product, required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteNotifierProvider);
    final notifier = ref.read(favoriteNotifierProvider.notifier);

    final isFavorite = state.favorites
        .any((f) => f.productId == product.productId && f.userId == user.id);

    final isLoading = state.loadingProductIds.contains(product.productId);

    return InkWell(
      onTap: isLoading
          ? null
          : () async {
              if (isFavorite) {
                final fav = state.favorites.firstWhere(
                  (f) =>
                      f.productId == product.productId && f.userId == user.id,
                );
                await notifier.removeUserFavorite(favorite: fav);
              } else {
                await notifier.addUserFavorite(
                  favorite: Favorite(
                    favoriteId: '',
                    productId: product.productId,
                    userId: user.id,
                  ),
                );
              }
            },
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white.withOpacity(0.5),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 14,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
    );
  }
}
