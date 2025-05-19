import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/home/presentation/providers/best_sellers_provider.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
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
    getCategoies(); // ✅ Safe to call async logic here
    getBestSellers();
    getRecommendeds();
  }

  Future<void> getCategoies() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();
    final categories = ref.read(categoriesNotifierProvider);
    print(categories);
  }

  Future<void> getBestSellers() async {
    await ref.read(bestSellersNotifier.notifier).getBestSellers();
    final bestBellers = ref.read(bestSellersNotifier);
    print(bestBellers);
  }

  Future<void> getRecommendeds() async {
    await ref.read(recommendedNotifierProvider.notifier).getRecommendeds();
    final recommendeds = ref.read(recommendedNotifierProvider);
    print(recommendeds);
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
