import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/entities/favorite.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/presentation/providers/best_sellers_provider.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
import 'package:food_app/features/home/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/home/presentation/providers/products_provider.dart';
import 'package:food_app/features/home/presentation/providers/recommendeds_provider.dart';
import 'package:food_app/features/product/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BestSellerGrid extends ConsumerStatefulWidget {
  BestSellerGrid({super.key});

  @override
  ConsumerState<BestSellerGrid> createState() => _BestSellerGridState();
}

class _BestSellerGridState extends ConsumerState<BestSellerGrid> {
  List<Product> bestSellerProducts = [];
  List<Category> categories = [];
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final best = await getBestSellers();
    final cats = await getCategoies();

    setState(() {
      bestSellerProducts = best;
      categories = cats;
    });
  }

  Future<List<Category>> getCategoies() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();
    final categories = ref.watch(categoriesNotifierProvider);

    return categories;
  }

  Future<List<Product>> getBestSellers() async {
    await ref.read(bestSellersNotifier.notifier).getBestSellers();
    final bestBellers = ref.watch(bestSellersNotifier);
    List<String> keys = bestBellers.map((bestSellerProduct) {
      return bestSellerProduct.productId;
    }).toList();
    await ref.read(productsNotifierProvider.notifier).getProducts(keys: keys);
    final products = ref.watch(productsNotifierProvider);
    return products;
  }

  void goToProductScreen({required Product product}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0, // Spacing between grid items horizontally
        mainAxisSpacing: 8.0, // Spacing between grid items vertically
        childAspectRatio: 0.7, // Adjust this for aspect ratio of the grid items
      ),
      itemCount: bestSellerProducts.length,
      itemBuilder: (BuildContext context, int index) {
        final product = bestSellerProducts[index];
        final url = categories
            .firstWhere(
              (category) => category.categoryId == product.categoryId,
              orElse: () => Category(
                  categoryId: '', category: '', imageUrl: ''), // or show error
            )
            .imageUrl;
        print("This is category url: $url");

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
                        path: categories
                            .firstWhere(
                              (category) =>
                                  category.categoryId == product.categoryId,
                              orElse: () => Category(
                                  categoryId: '',
                                  category: '',
                                  imageUrl: ''), // or show error
                            )
                            .imageUrl,
                      ),
                    ),
                    // Favorite Icon (Top-right)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final favs = ref.watch(favoriteNotifierProvider);
                          final currentUser =
                              ref.watch(authUserNotifierProvider);
                          final favoriteNotifier =
                              ref.read(favoriteNotifierProvider.notifier);
                          final isFavorite = favs
                              .any((fav) => fav.productId == product.productId);

                          return InkWell(
                            onTap: () async {
                              if (currentUser == null) return;

                              if (isFavorite) {
                                final toRemove = favs.firstWhere((fav) =>
                                    fav.productId == product.productId);
                                await favoriteNotifier.removeUserFavorite(
                                    favorite: toRemove);
                              } else {
                                await favoriteNotifier.addUserFavorite(
                                  favorite: Favorite(
                                    favoriteId: '',
                                    productId: product.productId,
                                    userId: currentUser.id,
                                  ),
                                );
                              }

                              await favoriteNotifier.getUserFavorite(
                                  user: currentUser);
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
                          Text("3.5",
                              style: GoogleFonts.leagueSpartan(
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              )),
                          SvgPicture.asset("rating-icons/rating.svg")
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
