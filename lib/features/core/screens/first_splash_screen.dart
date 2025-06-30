import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

import 'dart:async';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});
  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 255.h),
            SvgPicture.asset(
              "assets/logo-icons/logo.svg",
              width: 200.w,
              height: 180.h,
            ),
            SizedBox(height: 26.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("YUM", style: AppTextStyles.textStyleLogoPart1),
                Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
              ],
            ),
            SizedBox(height: 308.h),
          ],
        ),
      ),
    );
  }
}
