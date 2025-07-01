import 'package:flutter/services.dart';
import 'package:food_app/features/core/constants/sizes.dart';

void statusBarBackgroundColor() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.yellowDark,
    statusBarIconBrightness: Brightness.light,
  ));
}
