import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
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
    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: AppColors.fontLight,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppHorizentalPaddingds.padding32),
                    decoration:
                        const BoxDecoration(color: AppColors.yellowDark),
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
                              "My Orders",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomFilledButton(
                                text: "Active",
                                fontSize: 17,
                                widht: 104.w,
                                height: 28.h,
                                backgroundColor: _currentPage == 0
                                    ? Colors.orange
                                    : Colors.grey,
                                callBack: () => _goToPage(0),
                              ),
                              CustomFilledButton(
                                text: "Completed",
                                fontSize: 17,
                                widht: 104.w,
                                height: 28.h,
                                backgroundColor: _currentPage == 1
                                    ? Colors.orange
                                    : Colors.grey,
                                callBack: () => _goToPage(1),
                              ),
                              CustomFilledButton(
                                text: "Cancelled",
                                fontSize: 17,
                                widht: 104.w,
                                height: 28.h,
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
