import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/carts/presentation/widgets/cart_list_view.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/orders/presentation/screens/confirm_order_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  int _currentIndex = 0;

  // Function to handle navigation
  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Add your custom navigation logic here
    // For now, we will navigate to a different screen based on the index
    if (_currentIndex == 0) {
      Navigator.pushReplacement(
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

  Future<void> goToconfirmOrderScreen() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ConfirmOrderScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);

    final cartItems = cart?.items ?? [];

    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: AppColors.fontLight,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(children: [
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
                        "Cart",
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
                    Text(
                      "You have ${cartItems.length} items in the cart",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 233, 83, 34),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // For example, you can add a list of products here
                    CartListView(),

                    cartItems.length != 0
                        ? Row(
                            children: [
                              Text("Subtotal"),
                              Spacer(),
                              Text(
                                  "\$${ref.watch(cartNotifierProvider)!.total.toStringAsFixed(2)}")
                            ],
                          )
                        : SizedBox.shrink(),
                    cartItems.length != 0
                        ? Row(
                            children: [
                              Text("Tax and fees"),
                              Spacer(),
                              Text("\$5.00")
                            ],
                          )
                        : SizedBox.shrink(),
                    cartItems.length != 0
                        ? Row(
                            children: [
                              Text("Delivery"),
                              Spacer(),
                              Text("\$3.00")
                            ],
                          )
                        : SizedBox.shrink(),
                    cartItems.length != 0 ? Divider() : SizedBox.shrink(),
                    cartItems.length != 0
                        ? Row(
                            children: [
                              Text("Total"),
                              Spacer(),
                              Text(
                                  "\$${(ref.watch(cartNotifierProvider)!.total + 8).toStringAsFixed(2)}")
                            ],
                          )
                        : SizedBox.shrink(),
                    cartItems.length != 0
                        ? CustomFilledButton(
                            text: "Checkout",
                            height: 36,
                            widht: 130,
                            fontSize: 20,
                            foregroundcolor: Colors.white,
                            callBack: goToconfirmOrderScreen,
                          )
                        : SizedBox.shrink(),
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
