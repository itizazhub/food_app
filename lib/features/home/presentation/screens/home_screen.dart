import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/best_sellers/presentation/screens/best_seller_screen.dart';
import 'package:food_app/features/best_sellers/presentation/widgets/best_seller_list_view.dart';
import 'package:food_app/features/carts/presentation/screens/cart_screen.dart';
import 'package:food_app/features/carts/presentation/widgets/cart_list_view.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/show_right_drawer.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:food_app/features/core/widgets/custom_input_text_field.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/home/presentation/widgets/profile_drawer.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/orders/presentation/screens/my_orders_screen.dart';
import 'package:food_app/features/products/presentation/providers/products_provider.dart';
import 'package:food_app/features/recommended/presentation/providers/recommendeds_provider.dart';
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

    if (_currentIndex == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecommendedScreen()));
    } else if (_currentIndex == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
    } else if (_currentIndex == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyOrdersScreen()));
    } else if (_currentIndex == 4) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Text("help")));
    }
  }

  void goToBestSellerScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BestSellerScreen()));
  }

  void goToRecommendedScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecommendedScreen()));
  }

  void goToCategoriesScreen({required String categoryId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoriesScreen(categoryId: categoryId)));
  }

  @override
  void initState() {
    super.initState();
  }

  void goToCartScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final categoriesState = ref.watch(categoriesNotifierProvider);
    final categories = categoriesState.categories;

    statusBarBackgroundColor();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppHorizentalPaddingds.padding32),
                decoration: const BoxDecoration(color: AppColors.yellowDark),
                height: AppContainerHeights.height170,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppSizedBoxHeights.height30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInputTextField(
                          width: 200.w,
                          height: 26.h,
                          radius: 30.r,
                        ),
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
                                width: 26.w,
                                height: 26.h,
                                radius: 9.r,
                                path: "assets/cart-icons/cart.svg",
                              ),
                            ),
                            const SizedBox(width: 8),
                            CustomIcon(
                              width: 26.w,
                              height: 26.h,
                              radius: 9.r,
                              path:
                                  "assets/notification-icons/notification.svg",
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                showRightDrawer(
                                    child: const ProfileDrawer(),
                                    context: context);
                              },
                              child: CustomIcon(
                                width: 26.w,
                                height: 26.h,
                                radius: 9.r,
                                path: "assets/profile-icons/profile.svg",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizedBoxHeights.height16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.textStyleAppBarTitle2,
                          ),
                          Text(
                            "Rise and shine! It's breakfast time",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.textStyleParagraph6,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130.h,
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
                  top: AppVerticalPaddingds.padding35,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (Category category in categories)
                            InkWell(
                              onTap: () => goToCategoriesScreen(
                                  categoryId: category.categoryId),
                              child: CustomIcon(
                                width: 50.w,
                                height: 62.h,
                                background:
                                    const Color.fromARGB(255, 255, 222, 207),
                                path: "assets/${category.imageUrl}",
                                label: category.category,
                                padding: 6.w,
                                radius: 23.r,
                              ),
                            ),
                        ],
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 255, 222, 207),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Seller",
                            style: AppTextStyles.textStyleAppBodyTitle2,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: goToBestSellerScreen,
                                style: AppTextButtonStyles.textButtonStyle4,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "view all",
                                      style: AppTextStyles.textButtonTextStyle3,
                                    ),
                                    SizedBox(width: AppSizedBoxWidths.width5),
                                    SvgPicture.asset(
                                      "assets/forward-arrow-icons/forward-arrow-icon.svg",
                                      width: AppSvgWidths.width8,
                                      height: AppSvgHeights.height12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      BestSellerListView(),
                      Container(
                        height: 128.h,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.asset(
                            "assets/meal-images/1.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizedBoxHeights.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended",
                            style: AppTextStyles.textStyleAppBodyTitle2,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: goToRecommendedScreen,
                                style: AppTextButtonStyles.textButtonStyle4,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "view all",
                                      style: AppTextStyles.textButtonTextStyle3,
                                    ),
                                    SizedBox(width: AppSizedBoxWidths.width5),
                                    SvgPicture.asset(
                                      "assets/forward-arrow-icons/forward-arrow-icon.svg",
                                      width: AppSvgWidths.width8,
                                      height: AppSvgHeights.height12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: AppSizedBoxHeights.height10),
                      const RecommendedGrid(),
                      TextButton(
                        onPressed: () async {
                          final user = User(
                              id: "-OPUxrBC0UHpf4kMnQMT",
                              username: "test",
                              email: "test@gmail.com",
                              password: "testUpdatedAgain1/",
                              isAdmin: false);

                          await ref
                              .read(categoriesNotifierProvider.notifier)
                              .getCategories();
                          await ref
                              .read(bestSellersNotifierProvider.notifier)
                              .getBestSellers();
                          await ref
                              .read(recommendedNotifierProvider.notifier)
                              .getRecommendedProducts();
                          await ref
                              .read(favoriteNotifierProvider.notifier)
                              .getUserFavorite(user: user);
                          await ref
                              .read(addressNotifierProvider.notifier)
                              .getUserAddresses(user: user);
                          await ref
                              .read(orderNotifierProvider.notifier)
                              .getUserOrders(user: user);
                          await ref
                              .read(productsNotifierProvider.notifier)
                              .getProducts();
                        },
                        child: const Text("update"),
                      ),
                    ],
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
          ],
        ),
      ),
    );
  }
}
