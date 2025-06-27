import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

/*
---colors---
yellow 245, 203, 88
light yellow 243, 233, 181
orange 233, 83, 34
light orange 255, 222, 207
font 1 57, 23, 19 darkone
font 2 248, 248, 248 lightone
---font sizes---
paragraph 14 league spartan light
title 24 26 league spartan bold
subtitle 20 league spartan medium 
screen title 28 league spartan bold
*/

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});
  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> {
  Future<void> _navigateToLogInPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _navigateToSignUpPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 83, 34),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 280),
            SvgPicture.asset(
              color: const Color.fromARGB(255, 245, 203, 88),
              "logo-icons/logo.svg",
              width: 200,
              height: 180,
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YUM",
                  style: TextStyles.textStyleLogoPart2,
                ),
                Text(
                  "QUICK",
                  style: TextStyles.textStyleLogoPart3,
                ),
              ],
            ),
            const SizedBox(height: 31),
            SizedBox(
              width: 295,
              child: Text(
                textAlign: TextAlign.center,
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
                style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 43),
            SizedBox(
              width: 207,
              height: 45,
              child: TextButton(
                onPressed: () {
                  _navigateToLogInPage();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // no internal padding
                  backgroundColor: const Color.fromARGB(
                      255, 245, 203, 88), // filled background
                  minimumSize: Size.zero, // prevent default min size
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // compact touch area
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // optional rounding
                  ),
                ),
                child: Text(
                  'Log In',
                  style: GoogleFonts.leagueSpartan(
                    color: const Color.fromARGB(255, 233, 83, 34),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: _navigateToSignUpPage,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // no internal padding
                backgroundColor: const Color.fromARGB(
                    255, 243, 233, 181), // filled background
                minimumSize: const Size(207, 45), // prevent default min size
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // compact touch area
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // optional rounding
                ),
              ),
              child: Text(
                'Sign Up',
                style: GoogleFonts.leagueSpartan(
                  color: const Color.fromARGB(255, 233, 83, 34),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
