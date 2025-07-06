import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderConfirmedScreen extends ConsumerStatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  ConsumerState<OrderConfirmedScreen> createState() =>
      _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends ConsumerState<OrderConfirmedScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  Future<void> goToHomeScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          "Order Placed",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Order Successfully Placed!"),
                    const SizedBox(height: 10),
                    const Text("Thank you for placing your order"),
                    const SizedBox(height: 20),
                    CustomFilledButton(
                      text: "Go to Home",
                      height: 36,
                      widht: 150,
                      fontSize: 20,
                      foregroundcolor: Colors.white,
                      callBack: goToHomeScreen,
                    ),
                    const SizedBox(height: 20),
                    CustomFilledButton(
                      text: "Go to My Orders",
                      height: 36,
                      widht: 200,
                      fontSize: 20,
                      foregroundcolor: Colors.white,
                      callBack: goToHomeScreen,
                    ),
                  ],
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
        ));
  }
}
