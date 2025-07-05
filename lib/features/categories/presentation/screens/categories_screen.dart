import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/products/presentation/providers/products_by_category_provider.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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

    if (categoryState.isLoading || state.isLoading) {
      return CircularProgressIndicator();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 203, 88),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        size: 18,
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 233, 83, 34),
                      ),
                    ),
                    Text(
                      "Meals",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 248, 248, 248),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 100,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              path: category.imageUrl,
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
                      ListView.builder(
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
                                color: const Color.fromARGB(255, 248, 248, 248),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
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
                                          padding: const EdgeInsets.symmetric(
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
                                                style:
                                                    GoogleFonts.leagueSpartan(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                "rating-icons/rating.svg",
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 233, 83, 34),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/home.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/categories.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/favorites.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/list.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/help.svg"),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
