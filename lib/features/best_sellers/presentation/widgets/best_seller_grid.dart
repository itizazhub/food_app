import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BestSellerGrid extends ConsumerStatefulWidget {
  BestSellerGrid({super.key});

  @override
  ConsumerState<BestSellerGrid> createState() => _BestSellerGridState();
}

class _BestSellerGridState extends ConsumerState<BestSellerGrid> {
  void goToProductScreen({required Product product}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authUserNotifierProvider).user;
    final bestSellersState = ref.watch(bestSellersNotifierProvider);
    final categoriesState = ref.watch(categoriesNotifierProvider);
    final categories = categoriesState.categories;
    final favState = ref.watch(favoriteNotifierProvider);
    final favStateNotifier = ref.watch(favoriteNotifierProvider.notifier);

    if (bestSellersState.isLoading || categoriesState.isLoading) {
      return const CircularProgressIndicator();
    }

    if (bestSellersState.failure != null || categoriesState.failure != null) {
      return Text("Error: ${bestSellersState.failure!.message}");
    }
    final products = bestSellersState.products;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0, // Spacing between grid items horizontally
        mainAxisSpacing: 8.0, // Spacing between grid items vertically
        childAspectRatio: 0.7, // Adjust this for aspect ratio of the grid items
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        final url = categories
            .firstWhere(
              (category) => category.categoryId == product.categoryId,
              orElse: () => Category(
                  categoryId: '', category: '', imageUrl: ''), // or show error
            )
            .imageUrl;
        return InkWell(
          onTap: () => goToProductScreen(product: product),
          child: Card(
            elevation: 0,
            color: const Color.fromARGB(255, 248, 248, 248),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior:
                      Clip.none, // Allow clipping of widgets outside the Stack
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 140,
                        width: double.infinity,
                      ),
                    ),
                    // Category Icon (Top-left)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CustomIcon(
                        path: "assets/${categories.firstWhere(
                              (category) =>
                                  category.categoryId == product.categoryId,
                              orElse: () => Category(
                                  categoryId: '',
                                  category: '',
                                  imageUrl: ''), // or show error
                            ).imageUrl}",
                      ),
                    ),
                    // Favorite Icon (Top-right)
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
                      bottom:
                          15, // Adjust the bottom position to place text appropriately
                      right:
                          0, // Adjust the left position to place text appropriately
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, left: 2),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 233, 83, 34),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),

                        // Optional: Adds a background to the text for better readability
                        child: Text(
                          "\$${product.price.toString()}",
                          style: GoogleFonts.leagueSpartan(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
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
                    Text(
                      product.productName,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.leagueSpartan(
                        color: Color.fromARGB(255, 57, 23, 19),
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 233, 83, 34),
                      ),
                      child: Row(
                        children: [
                          Text(product.rating.toStringAsFixed(1),
                              style: GoogleFonts.leagueSpartan(
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              )),
                          SvgPicture.asset("assets/rating-icons/rating.svg")
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 125,
                      child: Text(
                        product.description,
                        style: GoogleFonts.leagueSpartan(
                          color: Color.fromARGB(255, 57, 23, 19),
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ), // Price
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color.fromARGB(255, 233, 83, 34),
                      foregroundColor: Color.fromARGB(255, 248, 248, 248),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 12,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
