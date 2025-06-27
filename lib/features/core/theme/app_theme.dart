import 'package:flutter/material.dart';
import 'package:food_app/features/core/theme/color_schemes.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
// import 'text_styles.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
).copyWith(
  textTheme: textStyles,
  colorScheme: kColorSchemeLight,
  scaffoldBackgroundColor: const Color.fromARGB(255, 245, 203, 88),
);
