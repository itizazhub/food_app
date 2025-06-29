import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'dart:async';

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
      backgroundColor: AppColors.orangeDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 280),
              SvgPicture.asset(
                color: AppColors.yellowDark,
                "logo-icons/logo.svg",
                width: 200,
                height: 180,
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("YUM", style: AppTextStyles.textStyleLogoPart2),
                  Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
                ],
              ),
              const SizedBox(height: 31),
              SizedBox(
                  width: 295,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
                    style: AppTextStyles.textStyleParagraph1,
                  )),
              const SizedBox(height: 43),
              TextButton(
                onPressed: () {
                  _navigateToLogInPage();
                },
                style: AppTextButtonStyles.textButtonStyle1,
                child: Text(
                  'Log In',
                  style: AppTextStyles.textButtonTextStyle1,
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: _navigateToSignUpPage,
                style: AppTextButtonStyles.textButtonStyle2,
                child: Text(
                  'Sign Up',
                  style: AppTextStyles.textButtonTextStyle1,
                ),
              ),
              const SizedBox(height: 119),
            ],
          ),
        ),
      ),
    );
  }
}
