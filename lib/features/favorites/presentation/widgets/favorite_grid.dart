import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';

class FavoriteGrid extends ConsumerStatefulWidget {
  const FavoriteGrid({super.key});

  @override
  ConsumerState<FavoriteGrid> createState() => _FavoriteGridState();
}

class _FavoriteGridState extends ConsumerState<FavoriteGrid> {
  void goToProductScreen({required Product product}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authUserNotifierProvider).user;
    final favState = ref.watch(favoriteNotifierProvider);
    final favStateNotifier = ref.watch(favoriteNotifierProvider.notifier);
    final categoryState = ref.watch(categoriesNotifierProvider);
    final prodState = ref.watch(productsNotifierProvider);
    final categories = categoryState.categories;
    final products = prodState.products
        .where((fav) => favState.favorites
            .any((product) => product.productId == fav.productId))
        .toList();

    if (favState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        final category = categories.firstWhereOrNull(
          (c) => c.categoryId == product.categoryId,
        );

        return InkWell(
          onTap: () => goToProductScreen(product: product),
          child: Card(
            elevation: 0,
            color: const Color(0xFFF8F8F8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 140,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CustomIcon(path: category!.imageUrl),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final isFavorite = products
                              .any((f) => f.productId == product.productId);

                          return InkWell(
                            onTap: () async {
                              if (currentUser == null) return;

                              if (isFavorite) {
                                final fav = favState.favorites.firstWhereOrNull(
                                    (f) => f.productId == product.productId);
                                await favStateNotifier.removeUserFavorite(
                                    favorite: fav!);
                              } else {
                                await favStateNotifier.addUserFavorite(
                                  favorite: Favorite(
                                    favoriteId: '',
                                    productId: product.productId,
                                    userId: currentUser.id,
                                  ),
                                );
                              }

                              await favStateNotifier.getUserFavorite(
                                  user: currentUser);
                              await ref
                                  .read(productsNotifierProvider.notifier)
                                  .getProducts();
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16,
                                color: isFavorite ? Colors.red : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE95322),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                        child: Text(
                          "\$${product.price}",
                          style: GoogleFonts.leagueSpartan(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.productName,
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF391713),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE95322),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 11,
                              color: const Color(0xFFF8F8F8),
                            ),
                          ),
                          const SizedBox(width: 2),
                          SvgPicture.asset("assets/rating-icons/rating.svg",
                              height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 125,
                      child: Text(
                        product.description,
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF391713),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xFFE95322),
                      foregroundColor: Color(0xFFF8F8F8),
                      child: Icon(Icons.shopping_cart, size: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
