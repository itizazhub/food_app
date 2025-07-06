import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/presentation/providers/products_by_category_provider.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/sizes.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  final String categoryId;
  const CategoriesScreen({super.key, required this.categoryId});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  int _currentIndex = 0;
  int selectedIndex = 0;

  void goToProductScreen({required Product product}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoriesNotifierProvider);
    final categories = categoryState.categories;
    final state = ref.watch(productsByCategoryNotifierProvider);
    final stateNotifier =
        ref.watch(productsByCategoryNotifierProvider.notifier);
    List<Product> products = state.products;
    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: AppColors.fontLight,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizedBoxHeights.height76),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/back-arrow-icons/back-arrow-icon.svg',
                            width: AppSvgWidths.width4,
                            height: AppSvgHeights.height9,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Meals",
                          style: AppTextStyles.textStyleAppBarTitle,
                        ),
                        const Spacer(),
                      ],
                    ),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: categories.map((category) {
                          final index = categories.indexOf(category);
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                selectedIndex = index;
                              });
                              await stateNotifier.getProductsByCategory(
                                categoryId: categories[index].categoryId,
                              );
                              // setState(() {
                              //   productsByCategory = newProducts;
                              // });
                            },
                            child: CustomIcon(
                              width: 50,
                              height: 62,
                              background: selectedIndex == index
                                  ? const Color.fromARGB(255, 245, 203, 88)
                                  : const Color.fromARGB(255, 255, 222, 207),
                              path: "assets/${category.imageUrl}",
                              label: category.category,
                              padding: 6,
                              radius: 23,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Text("Sorted By"),
                              SizedBox(width: 10),
                              Text("Popular")
                            ],
                          ),
                          const Icon(Icons.filter_list_alt)
                        ],
                      ),
                      const SizedBox(height: 20),
                      categoryState.isLoading || state.isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return InkWell(
                                  onTap: () {
                                    goToProductScreen(product: product);
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: const Color.fromARGB(
                                        255, 248, 248, 248),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.asset(
                                            product.imageUrl,
                                            fit: BoxFit.cover,
                                            height: 174,
                                            width: double.infinity,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              product.productName,
                                              style: GoogleFonts.leagueSpartan(
                                                color: const Color.fromARGB(
                                                    255, 57, 23, 19),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: const Color.fromARGB(
                                                    255, 233, 83, 34),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    product.rating
                                                        .toStringAsFixed(1),
                                                    style: GoogleFonts
                                                        .leagueSpartan(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/rating-icons/rating.svg",
                                                    height: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "\$${product.price.toString()}",
                                              style: GoogleFonts.leagueSpartan(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          product.description,
                                          style: GoogleFonts.leagueSpartan(
                                            color: const Color.fromARGB(
                                                255, 57, 23, 19),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
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
