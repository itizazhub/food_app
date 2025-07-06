import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:food_app/features/recommended/presentation/widgets/product_card.dart';
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
    // final currentUser = ref.watch(authUserNotifierProvider).user;
    final currentUser = User(
        id: "-OPUxrBC0UHpf4kMnQMT",
        username: "test",
        email: "test@gmail.com",
        password: "testUpdatedAgain1/",
        isAdmin: false);
    final favState = ref.watch(favoriteNotifierProvider);
    final categoryState = ref.watch(categoriesNotifierProvider);
    final prodState = ref.watch(productsNotifierProvider);
    final categories = categoryState.categories;
    final products = prodState.products
        .where((fav) => favState.favorites
            .any((product) => product.productId == fav.productId))
        .toList();

    if (favState.isFetchingFavorites) {
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
        final category = categories.firstWhere(
          (c) => c.categoryId == product.categoryId,
          orElse: () => Category(categoryId: '', category: '', imageUrl: ''),
        );

        return ProductCard(
          product: product,
          category: category,
          currentUser: currentUser,
        );
      },
    );
  }
}
