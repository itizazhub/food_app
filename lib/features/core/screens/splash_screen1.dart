import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/splash_screen2.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

import 'dart:async';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});
  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()),
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
            SizedBox(height: AppSizedBoxHeights.height255),
            logo(),
            SizedBox(height: AppSizedBoxHeights.height308),
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/logo-icons/logo.svg",
          width: AppSvgWidths.width200,
          height: AppSvgHeights.height180,
        ),
        SizedBox(height: AppSizedBoxHeights.height26),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("YUM", style: AppTextStyles.textStyleLogoPart1),
            Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
          ],
        ),
      ],
    );
  }
}
