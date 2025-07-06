import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
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
import 'package:food_app/features/recommended/presentation/widgets/favorite_button.dart';
import 'package:food_app/features/recommended/presentation/widgets/product_card.dart';

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
    // final currentUser = ref.watch(authUserNotifierProvider).user;
    final currentUser = User(
        id: "-OPUxrBC0UHpf4kMnQMT",
        username: "test",
        email: "test@gmail.com",
        password: "testUpdatedAgain1/",
        isAdmin: false);

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

        return ProductCard(
          product: product,
          category: category,
          currentUser: currentUser,
        );
      },
    );
  }
}
