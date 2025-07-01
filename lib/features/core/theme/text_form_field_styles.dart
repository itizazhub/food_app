import 'package:flutter/material.dart';
import 'package:food_app/features/core/constants/sizes.dart';

class TextFormFieldStyles {
  static InputDecoration appInputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      alignLabelWithHint: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.yellowLight,
      contentPadding: EdgeInsets.symmetric(
        vertical: AppVerticalPaddingds.padding15,
        horizontal: AppHorizentalPaddingds.padding15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiuses.radius13),
        borderSide: const BorderSide(color: AppColors.yellowDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiuses.radius13),
        borderSide: const BorderSide(color: AppColors.yellowDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiuses.radius13),
        borderSide: const BorderSide(color: AppColors.yellowDark),
      ),
    );
  }
}
