import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/orders/presentation/widgets/active_page.dart';
import 'package:food_app/features/orders/presentation/widgets/cancelled_page.dart';
import 'package:food_app/features/orders/presentation/widgets/completed_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrders();
    });
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
    });

    await ref.read(orderNotifierProvider.notifier).getUserOrders(
          user: User(
            id: "-OPUxrBC0UHpf4kMnQMT",
            username: "test",
            email: "test@gmail.com",
            password: "test123",
            isAdmin: false,
          ),
        );

    setState(() {
      _isLoading = false;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Add your custom navigation logic here
    // For now, we will navigate to a different screen based on the index
    if (_currentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (_currentIndex == 1) {
      // Handle second navigation, e.g., go to Categories
    } else if (_currentIndex == 2) {
      // Handle third navigation, e.g., go to Favorites
    } else if (_currentIndex == 3) {
      // Handle fourth navigation, e.g., go to List
    } else if (_currentIndex == 4) {
      // Handle fifth navigation, e.g., go to Help
    }
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Widget> _pages = [ActivePage(), CompletedPage(), CancelledPage()];

  Future<void> _goToPage(int index) async {
    setState(() {
      _currentPage = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                // Top section (title, back button)
                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 203, 88),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Go back to the previous screen
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            size: 18,
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 233, 83, 34),
                          ),
                        ),
                        Text(
                          "My Orders",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 248, 248, 248),
                          ),
                        ),
                        SizedBox(
                            width: 50), // You can remove this if not needed
                      ],
                    ),
                  ),
                ),

                // Bottom section with rounded corners
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 100,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .8,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    // Adjust height to avoid overlap with keyboard
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomFilledButton(
                                text: "Active",
                                fontSize: 18,
                                widht: 140,
                                height: 40,
                                backgroundColor: _currentPage == 0
                                    ? Colors.orange
                                    : Colors.grey,
                                callBack: () => _goToPage(0),
                              ),
                              CustomFilledButton(
                                text: "Completed",
                                fontSize: 18,
                                widht: 140,
                                height: 40,
                                backgroundColor: _currentPage == 1
                                    ? Colors.orange
                                    : Colors.grey,
                                callBack: () => _goToPage(1),
                              ),
                              CustomFilledButton(
                                text: "Cancelled",
                                fontSize: 18,
                                widht: 140,
                                height: 40,
                                backgroundColor: _currentPage == 2
                                    ? Colors.orange
                                    : Colors.grey,
                                callBack: () => _goToPage(2),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 300,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: _pages.length,
                              onPageChanged: (index) => setState(() {
                                _currentPage = index;
                              }),
                              itemBuilder: (context, index) => _pages[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
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
          onTap: _onNavItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/home.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/categories.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/favorites.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/list.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/help.svg",
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}
