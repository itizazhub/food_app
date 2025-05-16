import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/product/presentation/screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  // If you want to use key, then use this, but it's not mandatory unless you need to use the key.
  const OnBoardingScreen({Key? key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/onboard.jpg", fit: BoxFit.cover)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color.fromARGB(255, 243, 233, 181),
                ),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, top: 10, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/order.svg",
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Order For Food",
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 83, 34),
                            fontSize: 24,
                            fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Your next action here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromARGB(255, 233, 83, 34),
                            ),
                            foregroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromARGB(255, 248, 248, 248),
                            ),
                            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsets.only(left: 50, right: 50))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
