import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/best-sellers/presentation/widgets/best_seller_grid.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/presentation/providers/categories_provider.dart';
import 'package:food_app/features/home/presentation/widgets/recommended_grid.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
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
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final cats = await getCategories();
    setState(() {
      categories = cats;
      selectedIndex = categories
          .indexWhere((category) => category.categoryId == widget.categoryId);
    });
  }

  Future<List<Category>> getCategories() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();
    final categories = ref.read(categoriesNotifierProvider);
    return categories;
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
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
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
                      Card(
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
                                "meal-images/1.jpg",
                                fit: BoxFit.cover,
                                height: 174,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "product title",
                                  style: GoogleFonts.leagueSpartan(
                                    color:
                                        const Color.fromARGB(255, 57, 23, 19),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromARGB(255, 233, 83, 34),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "3.5",
                                        style: GoogleFonts.leagueSpartan(
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
                                  "\$33.00",
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
                              "Premium cocoa, melted chocolate, and a hint of vanilla, creating a moist, fudgy center with a crisp, crackly top.",
                              style: GoogleFonts.leagueSpartan(
                                color: const Color.fromARGB(255, 57, 23, 19),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
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
