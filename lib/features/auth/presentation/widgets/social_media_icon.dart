import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/constants/sizes.dart';

class SocialMediaIcon extends StatelessWidget {
  SocialMediaIcon({super.key, required this.path});
  String path;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: AppSvgWidths.width40,
      height: AppSvgHeights.height40,
    );
  }
}
