import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/presentation/providers/best_sellers_provider.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
import 'package:food_app/features/home/presentation/providers/products_provider.dart';
import 'package:food_app/features/home/presentation/providers/recommendeds_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getCategoies();
    await getBestSellers();
    final keys = await getRecommendeds();
    await getProducts(keys: keys);
  }

  Future<void> getCategoies() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();
    final categories = ref.read(categoriesNotifierProvider);
    print(categories[0].categoryId);
    print(categories[0].category);
    print(categories[0].imageUrl);
  }

  Future<void> getBestSellers() async {
    await ref.read(bestSellersNotifier.notifier).getBestSellers();
    final bestBellers = ref.read(bestSellersNotifier);
    print(bestBellers[0].productId);
  }

  Future<List<String>> getRecommendeds() async {
    await ref.read(recommendedNotifierProvider.notifier).getRecommendeds();
    final recommendeds = ref.read(recommendedNotifierProvider);
    return recommendeds.map((recommendedProduct) {
      return recommendedProduct.productId;
    }).toList();
  }

  Future<void> getProducts({required List<String> keys}) async {
    await ref.read(productsNotifierProvider.notifier).getProducts(keys: keys);
    final products = ref.read(productsNotifierProvider);
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: Text("Welcome to home screen"),
    );
  }
}
