import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
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
  List<Product> favoriteProducts = [];
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final user = ref.read(authUserNotifierProvider).user;
    if (user == null) return;

    final favoriteNotifier = ref.read(favoriteNotifierProvider.notifier);
    final categoryNotifier = ref.read(categoriesNotifierProvider.notifier);
    final productNotifier = ref.read(productsNotifierProvider.notifier);

    await favoriteNotifier.getUserFavoriteUseCase(user: user);
    final favorites = ref.read(favoriteNotifierProvider);
    final productIds = favorites.map((f) => f.productId).toList();

    await productNotifier.getProducts(keys: productIds);
    await categoryNotifier.getCategories();

    setState(() {
      favoriteProducts = ref.read(productsNotifierProvider);
      categories = ref.read(categoriesNotifierProvider);
      isLoading = false;
    });
  }

  void goToProductScreen({required Product product}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
      itemCount: favoriteProducts.length,
      itemBuilder: (BuildContext context, int index) {
        final product = favoriteProducts[index];
        final category = categories.firstWhere(
          (c) => c.categoryId == product.categoryId,
          orElse: () => Category(categoryId: '', category: '', imageUrl: ''),
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
                      child: CustomIcon(path: category.imageUrl),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final favs = ref.watch(favoriteNotifierProvider);
                          final currentUser =
                              ref.watch(authUserNotifierProvider).user;
                          final notifier =
                              ref.read(favoriteNotifierProvider.notifier);
                          final isFavorite =
                              favs.any((f) => f.productId == product.productId);

                          return InkWell(
                            onTap: () async {
                              if (currentUser == null) return;

                              if (isFavorite) {
                                final fav = favs.firstWhere(
                                    (f) => f.productId == product.productId);
                                await notifier.removeUserFavorite(
                                    favorite: fav);
                              } else {
                                await notifier.addUserFavorite(
                                  favorite: Favorite(
                                    favoriteId: '',
                                    productId: product.productId,
                                    userId: currentUser.id,
                                  ),
                                );
                              }

                              await notifier.getUserFavorite(user: currentUser);
                              await ref
                                  .read(productsNotifierProvider.notifier)
                                  .getProducts(
                                      keys: favs
                                          .map((f) => f.productId)
                                          .toList());
                              setState(() {
                                favoriteProducts =
                                    ref.read(productsNotifierProvider);
                              });
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
                            "3.5",
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 11,
                              color: const Color(0xFFF8F8F8),
                            ),
                          ),
                          const SizedBox(width: 2),
                          SvgPicture.asset("rating-icons/rating.svg",
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
