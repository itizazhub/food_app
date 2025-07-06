import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/carts/presentation/screens/cart_screen.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/core/screens/on_boarding_screen1.dart';
import 'package:food_app/features/core/screens/splash_screen1.dart';
import 'package:food_app/features/core/theme/app_theme.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/orders/presentation/screens/confirm_order_screen.dart';
import 'package:food_app/features/orders/presentation/screens/my_orders_screen.dart';
import 'package:food_app/features/orders/presentation/screens/payment_method_screen.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:food_app/features/recommended/presentation/providers/recommendeds_provider.dart';
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
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          theme: appTheme,
          // darkTheme: ThemeData(
          //   useMaterial3: true,
          // ),
          // themeMode: ThemeMode.system,

          // MyOrdersScreen(),
          //FirstSplashScreen(), //FirstSplashScreen(), // ConfirmOrderScreen(), PaymentMethodScreen(),
          // CartScreen(), // ProductScreen(), // HomeScreen(),
        );
      },
    );
  }
}


// fix the code in home right drawer for user profile 


// things to do //
// handle get request for one or more elements

// use go router for navigation
// equatable for object comparision
// retrofit for api requests
// either(righ left)
// freeze for code generation
