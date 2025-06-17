import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // Top section (title, back button)
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
                      // Go back to the previous screen
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      size: 18,
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 233, 83, 34),
                    ),
                  ),
                  Text(
                    "Order placed",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  const SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 233, 83, 34),
        items: [
          _navItem("home"),
          _navItem("categories"),
          _navItem("favorites"),
          _navItem("list"),
          _navItem("help"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(String iconName) {
    return BottomNavigationBarItem(
      icon:
          SvgPicture.asset("bottom-navigation-icons/$iconName.svg", height: 24),
      label: '',
    );
  }
}
