import 'package:flutter/material.dart';
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
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 280),
              SvgPicture.asset(
                "logo-icons/logo.svg",
                width: 200,
                height: 180,
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("YUM", style: AppTextStyles.textStyleLogoPart1),
                  Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
                ],
              ),
              const SizedBox(height: 308),
            ],
          ),
        ),
      ),
    );
  }
}
