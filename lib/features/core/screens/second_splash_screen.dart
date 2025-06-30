import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 255.h),
            SvgPicture.asset(
              color: AppColors.yellowDark,
              "assets/logo-icons/logo.svg",
              width: 200.w,
              height: 180.h,
            ),
            SizedBox(height: 26.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("YUM", style: AppTextStyles.textStyleLogoPart2),
                Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
              ],
            ),
            SizedBox(height: 31.h),
            SizedBox(
                width: 295.w,
                child: Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
                  style: AppTextStyles.textStyleParagraph1,
                )),
            SizedBox(height: 43.h),
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
            SizedBox(height: 4.h),
            TextButton(
              onPressed: _navigateToSignUpPage,
              style: AppTextButtonStyles.textButtonStyle2,
              child: Text(
                'Sign Up',
                style: AppTextStyles.textButtonTextStyle1,
              ),
            ),
            SizedBox(height: 119.h),
          ],
        ),
      ),
    );
  }
}
