import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class FirstSplashScreen extends StatefulWidget {
  FirstSplashScreen({super.key});
  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  initState() {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecondSplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 203, 88),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "logo-icons/logo.svg",
                width: 200,
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "YUM",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 233, 83, 34),
                        fontSize: 34,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "QUICK",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontSize: 34,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
