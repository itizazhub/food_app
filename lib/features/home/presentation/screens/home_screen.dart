import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/widgets/best_seller_list_view.dart';
import 'package:food_app/features/core/widgets/custom_input_text_field.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/core/widgets/home_grid.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/presentation/providers/best_sellers_provider.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
import 'package:food_app/features/home/presentation/providers/products_provider.dart';
import 'package:food_app/features/home/presentation/providers/recommendeds_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Category> categoies = [];
  List<Product> recommendedProducts = [];
  List<Product> bestSellerProducts = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    categoies = await getCategoies();
    bestSellerProducts = await getBestSellers();
    recommendedProducts = await getRecommendeds();
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

  Future<List<Product>> getRecommendeds() async {
    await ref.read(recommendedNotifierProvider.notifier).getRecommendeds();
    final recommendeds = ref.watch(recommendedNotifierProvider);
    List<String> keys = recommendeds.map((recommendedProduct) {
      return recommendedProduct.productId;
    }).toList();
    await ref.read(productsNotifierProvider.notifier).getProducts(keys: keys);
    final products = ref.watch(productsNotifierProvider);
    return products;
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle screen navigation based on selected index
    if (_currentIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Text("recommendations")), //RecommendationsScreen()
      );
    } else if (_currentIndex == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Text("help")), //HelpScreen()
      );
    } else if (_currentIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Text("favorites")), //FavoritesScreen()
      );
    }
    // You can add additional navigation conditions for other indices if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 148, 100, 100),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding:
                    EdgeInsets.only(top: 40, bottom: 10, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 203, 88),
                ),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInputTextField(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIcon(path: "cart-icons/cart.svg"),
                            const SizedBox(width: 8),
                            CustomIcon(
                                path: "notification-icons/notification.svg"),
                            const SizedBox(width: 8),
                            CustomIcon(path: "profile-icons/profile.svg"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 248, 248, 248),
                            ),
                          ),
                          Text(
                            "Rise and shine! It's breakfast time",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 233, 83, 34),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIcon(
                              width: 50,
                              height: 62,
                              background:
                                  const Color.fromARGB(255, 255, 222, 207),
                              path: "categories-icons/Snacks.svg",
                              label: "Snacks",
                              padding: 6,
                              radius: 23,
                            ),
                            CustomIcon(
                              width: 50,
                              height: 62,
                              background:
                                  const Color.fromARGB(255, 255, 222, 207),
                              path: "categories-icons/Meals.svg",
                              label: "Meals",
                              padding: 6,
                              radius: 23,
                            ),
                            CustomIcon(
                              width: 50,
                              height: 62,
                              background:
                                  const Color.fromARGB(255, 255, 222, 207),
                              path: "categories-icons/Vegan.svg",
                              label: "Vegan",
                              padding: 6,
                              radius: 23,
                            ),
                            CustomIcon(
                              width: 50,
                              height: 62,
                              background:
                                  const Color.fromARGB(255, 255, 222, 207),
                              path: "categories-icons/Desserts.svg",
                              label: "Desserts",
                              padding: 6,
                              radius: 23,
                            ),
                            CustomIcon(
                              width: 50,
                              height: 62,
                              background:
                                  const Color.fromARGB(255, 255, 222, 207),
                              path: "categories-icons/Drinks.svg",
                              label: "Drinks",
                              padding: 6,
                              radius: 23,
                            ),
                          ],
                        ),
                        const Divider(
                            color: Color.fromARGB(255, 255, 222, 207),
                            thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Best Seller",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 57, 23, 19),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: null,
                              label: Text(
                                "view all",
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 233, 83, 34),
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 233, 83, 34),
                                size: 8,
                              ),
                              iconAlignment: IconAlignment.end,
                            )
                          ],
                        ),
                        BestSellerListView(),
                        Container(
                          height: 128,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                23), // Optional: Adds rounded corners to the image
                            child: Image.asset(
                              "meal-images/1.jpg",
                              fit: BoxFit
                                  .cover, // Optional: Ensures the image covers the entire container
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Recommended",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 57, 23, 19),
                          ),
                        ),
                        const SizedBox(height: 10),
                        HomeGrid(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), // Round top-left corner
          topRight: Radius.circular(12), // Round top-right corner
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromARGB(255, 233, 83, 34),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap:
              _onNavItemTapped, // Call this function when a nav item is tapped
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/home.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/categories.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/favorites.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/list.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/help.svg",
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}
