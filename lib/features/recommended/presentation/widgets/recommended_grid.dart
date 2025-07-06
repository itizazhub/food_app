import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/favorites/domain/entities/favorite.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:food_app/features/recommended/presentation/providers/recommendeds_provider.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedGrid extends ConsumerStatefulWidget {
  const RecommendedGrid({super.key});

  @override
  ConsumerState<RecommendedGrid> createState() => _RecommendedGridState();
}

class _RecommendedGridState extends ConsumerState<RecommendedGrid> {
  void goToProductScreen({required Product product}) {
    Navigator.push(
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
    final categories = categoryState.categories;
    final recommendedState = ref.watch(recommendedNotifierProvider);
    final products = recommendedState.products;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final category = categories.firstWhere(
          (c) => c.categoryId == product.categoryId,
          orElse: () => Category(categoryId: '', category: '', imageUrl: ''),
        );

        return InkWell(
          onTap: () => goToProductScreen(product: product),
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
                        height: 140.h,
                        width: 160.w,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CustomIcon(
                        width: 26.w,
                        height: 26.h,
                        radius: 9.r,
                        path: "assets/${category.imageUrl}",
                      ),
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
                              radius: 12.r,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 14.r,
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
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 83, 34),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            bottomLeft: Radius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: AppTextStyles.textStyleParagraph7,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizedBoxHeights.height10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.productName,
                        style: AppTextStyles.textStyleAppBodyTitle4,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.r),
                        color: const Color.fromARGB(255, 233, 83, 34),
                      ),
                      child: Row(
                        children: [
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: AppTextStyles.textStyleParagraph7,
                          ),
                          SvgPicture.asset("assets/rating-icons/rating.svg")
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 115.w,
                      child: Text(
                        product.description,
                        style: AppTextStyles.textStyleParagraph5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const CircleAvatar(
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
