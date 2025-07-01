import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/entities/favorite.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
import 'package:food_app/features/home/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/home/presentation/providers/products_provider.dart';
import 'package:food_app/features/home/presentation/providers/recommendeds_provider.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedGrid extends ConsumerStatefulWidget {
  const RecommendedGrid({super.key});

  @override
  ConsumerState<RecommendedGrid> createState() => _RecommendedGridState();
}

class _RecommendedGridState extends ConsumerState<RecommendedGrid> {
  List<Product> recommendedProducts = [];
  List<Category> categories = [];
  List<Favorite> favorites = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final recommended = await getRecommendeds();
    final cats = await getCategories();
    final favs = await getFavorites();
    setState(() {
      recommendedProducts = recommended;
      categories = cats;
      favorites = favs;
    });
  }

  Future<List<Category>> getCategories() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();
    return ref.read(categoriesNotifierProvider);
  }

  Future<List<Product>> getRecommendeds() async {
    await ref.read(recommendedNotifierProvider.notifier).getRecommendeds();
    final recommendeds = ref.read(recommendedNotifierProvider);
    final keys = recommendeds.map((e) => e.productId).toList();
    await ref.read(productsNotifierProvider.notifier).getProducts(keys: keys);
    return ref.read(productsNotifierProvider);
  }

  Future<List<Favorite>> getFavorites() async {
    final user = ref.read(authUserNotifierProvider).user;
    if (user != null) {
      await ref
          .read(favoriteNotifierProvider.notifier)
          .getUserFavorite(user: user);
    }
    return ref.read(favoriteNotifierProvider);
  }

  void goToProductScreen({required Product product}) {
    Navigator.push(
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
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: recommendedProducts.length,
      itemBuilder: (context, index) {
        final product = recommendedProducts[index];
        final category = categories.firstWhere(
          (c) => c.categoryId == product.categoryId,
          orElse: () => Category(categoryId: '', category: '', imageUrl: ''),
        );

        return InkWell(
          onTap: () => goToProductScreen(product: recommendedProducts[index]),
          child: Card(
            elevation: 0,
            color: const Color.fromARGB(255, 248, 248, 248),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
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
                      bottom: 15,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, left: 2),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 233, 83, 34),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
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
                    Expanded(
                      child: Text(
                        product.productName,
                        style: GoogleFonts.leagueSpartan(
                          color: const Color.fromARGB(255, 57, 23, 19),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 233, 83, 34),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "3.5",
                            style: GoogleFonts.leagueSpartan(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 11,
                            ),
                          ),
                          SvgPicture.asset("rating-icons/rating.svg")
                        ],
                      ),
                    )
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
                          color: const Color.fromARGB(255, 57, 23, 19),
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final cart = ref.watch(cartNotifierProvider);
                      final cartNotifier =
                          ref.read(cartNotifierProvider.notifier);

                      final cartItems = cart?.items ?? [];
                      final isAdded = cartItems.any((cartItem) {
                        return cartItem.productId ==
                            recommendedProducts[index].productId;
                      });

                      return InkWell(
                        onTap: () async {
                          if (!isAdded) {
                            cartNotifier.addItemToCart(
                                cartItem: CartItem(
                                    productId:
                                        recommendedProducts[index].productId,
                                    quantity: 1,
                                    price: recommendedProducts[index].price,
                                    imageUrl:
                                        recommendedProducts[index].imageUrl),
                                maxQuantity:
                                    recommendedProducts[index].stockQuantity);
                          } else {
                            cartNotifier.removeItemFromCart(
                                cartItem: cartItems.firstWhere((cartItem) {
                              return cartItem.productId ==
                                  recommendedProducts[index].productId;
                            }));
                          }
                        },
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: isAdded
                              ? Color.fromARGB(255, 226, 216, 216)
                              : const Color.fromARGB(255, 214, 35, 35),
                          foregroundColor: isAdded
                              ? Color.fromARGB(255, 223, 43, 43)
                              : Color.fromARGB(255, 248, 248, 248),
                          child: const Icon(
                            Icons.shopping_cart,
                            size: 12,
                          ),
                        ),
                      );
                    }),
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
