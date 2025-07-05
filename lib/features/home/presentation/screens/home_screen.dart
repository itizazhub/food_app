import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/best_sellers/presentation/screens/best_seller_screen.dart';
import 'package:food_app/features/best_sellers/presentation/widgets/best_seller_list_view.dart';
import 'package:food_app/features/carts/presentation/screens/cart_screen.dart';
import 'package:food_app/features/carts/presentation/widgets/cart_list_view.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/widgets/show_right_drawer.dart';
import 'package:food_app/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:food_app/features/core/widgets/custom_input_text_field.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/home/presentation/widgets/profile_drawer.dart';
import 'package:food_app/features/recommended/presentation/screens/recommended_screen.dart';
import 'package:food_app/features/recommended/presentation/widgets/recommended_grid.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle screen navigation based on selected index
    if (_currentIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecommendedScreen(),
          ) //RecommendationsScreen()
          );
    } else if (_currentIndex == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Text("help")), //HelpScreen()
      );
    } else if (_currentIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoriteScreen()), //
      );
    }
    // You can add additional navigation conditions for other indices if needed.
  }

  void goToBestSellerScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BestSellerScreen()), //RecommendationsScreen()
    );
  }

  void goToRecommendedScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecommendedScreen()), //RecommendationsScreen()
    );
  }

  void goToCategoriesScreen({required String categoryId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoriesScreen(
                categoryId: categoryId,
              )), //RecommendationsScreen()
    );
  }

  void goToCartScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesNotifierProvider);
    final categories = categoriesState.categories;
    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: true, // Ensure UI adjusts with keyboard
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppHorizentalPaddingds.padding32),
                decoration: const BoxDecoration(
                  color: AppColors.yellowDark,
                ),
                height: AppContainerHeights.height170,
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
                            InkWell(
                                onTap: () {
                                  showRightDrawer(
                                      child: const CartListView(),
                                      context: context);
                                },
                                child: CustomIcon(
                                    path: "assets/cart-icons/cart.svg")),
                            const SizedBox(width: 8),
                            CustomIcon(
                                path:
                                    "assets/notification-icons/notification.svg"),
                            const SizedBox(width: 8),
                            InkWell(
                                onTap: () {
                                  showRightDrawer(
                                      child: const ProfileDrawer(),
                                      context: context);
                                },
                                child: CustomIcon(
                                    path: "assets/profile-icons/profile.svg")),
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
              top: 114.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadiuses.radius30),
                    topRight: Radius.circular(AppRadiuses.radius30),
                  ),
                  color: AppColors.fontLight,
                ),
                padding: EdgeInsets.only(
                    left: AppHorizentalPaddingds.padding32,
                    right: AppHorizentalPaddingds.padding32,
                    top: AppVerticalPaddingds.padding35),
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
                            for (Category category in categories)
                              InkWell(
                                onTap: () {
                                  goToCategoriesScreen(
                                      categoryId: category.categoryId);
                                },
                                child: CustomIcon(
                                  width: 50,
                                  height: 62,
                                  background:
                                      const Color.fromARGB(255, 255, 222, 207),
                                  path: "assets/${category.imageUrl}",
                                  label: category.category,
                                  padding: 6,
                                  radius: 23,
                                ),
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
                              onPressed: goToBestSellerScreen,
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
                              "assets/meal-images/1.jpg",
                              fit: BoxFit
                                  .cover, // Optional: Ensures the image covers the entire container
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recommended",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 57, 23, 19),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: goToRecommendedScreen,
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
                        const SizedBox(height: 10),
                        const RecommendedGrid(),
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
          topLeft: Radius.circular(AppRadiuses.radius30),
          topRight: Radius.circular(AppRadiuses.radius30),
        ),
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.orangeDark,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onNavItemTapped,
            items: [
              item("assets/bottom-navigation-icons/home.svg"),
              item("assets/bottom-navigation-icons/categories.svg"),
              item("assets/bottom-navigation-icons/favorites.svg"),
              item("assets/bottom-navigation-icons/list.svg"),
              item("assets/bottom-navigation-icons/help.svg"),
            ]),
      ),
    );
  }
}
