import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/carts/presentation/screens/cart_screen.dart';
import 'package:food_app/features/core/screens/first_splash_screen.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/orders/presentation/screens/confirm_order_screen.dart';
import 'package:food_app/features/orders/presentation/screens/my_orders_screen.dart';
import 'package:food_app/features/orders/presentation/screens/payment_method_screen.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:food_app/right_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyOrdersScreen(),
      //FirstSplashScreen(), //FirstSplashScreen(), // ConfirmOrderScreen(), PaymentMethodScreen(), RightDrawer()
      // CartScreen(), // ProductScreen(), // HomeScreen(),
    );
  }
}

// things to do //
// handle get request for one or more elements

// use go router for navigation
// equatable for object comparision
// retrofit for api requests
// either(righ left)
// freeze for code generation
