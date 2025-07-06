import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:food_app/features/recommended/presentation/widgets/product_card.dart';

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
    // final currentUser = ref.watch(authUserNotifierProvider).user;
    final currentUser = User(
        id: "-OPUxrBC0UHpf4kMnQMT",
        username: "test",
        email: "test@gmail.com",
        password: "testUpdatedAgain1/",
        isAdmin: false);

    final bestSellersState = ref.watch(bestSellersNotifierProvider);
    final categoriesState = ref.watch(categoriesNotifierProvider);
    final categories = categoriesState.categories;

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
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 0.7, // Adjust this for aspect ratio of the grid items
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
