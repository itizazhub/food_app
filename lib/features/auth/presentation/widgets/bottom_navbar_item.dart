import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/constants/sizes.dart';

BottomNavigationBarItem item(String path) {
  return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        path,
        width: AppSvgWidths.width25,
        height: AppSvgHeights.height22,
      ),
      label: "");
}
