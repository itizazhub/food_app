import 'package:flutter/material.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final textStyleLogoPart1 = GoogleFonts.poppins(
      color: AppColors.orangeDark,
      fontSize: AppFontSizes.fontSize6,
      fontWeight: AppFontWeights.extraBold);

  static final textStyleLogoPart2 = GoogleFonts.poppins(
      color: AppColors.yellowDark,
      fontSize: AppFontSizes.fontSize6,
      fontWeight: AppFontWeights.extraBold);
  static final textStyleLogoPart3 = GoogleFonts.poppins(
      color: AppColors.fontLight,
      fontSize: AppFontSizes.fontSize6,
      fontWeight: AppFontWeights.extraBold);

  static final textButtonTextStyle1 = GoogleFonts.leagueSpartan(
    color: AppColors.orangeDark,
    fontSize: AppFontSizes.fontSize3,
    fontWeight: AppFontWeights.medium,
  );

  static final textButtonTextStyle2 = GoogleFonts.leagueSpartan(
    color: AppColors.fontLight,
    fontSize: AppFontSizes.fontSize3,
    fontWeight: AppFontWeights.medium,
  );

  static final textStyleParagraph1 = GoogleFonts.poppins(
    color: AppColors.fontLight,
    fontSize: AppFontSizes.fontSize1,
    fontWeight: AppFontWeights.medium,
  );
}

final TextTheme textStyles =
    TextTheme(displayLarge: AppTextStyles.textStyleLogoPart1);



/*
| Figma Font Name | Flutter `FontWeight` |
| --------------- | -------------------- |
| Extra Light     | `FontWeight.w200`    |
| Light           | `FontWeight.w300`    |
| Regular         | `FontWeight.w400`    |
| Medium          | `FontWeight.w500`    |
| Semi Bold       | `FontWeight.w600`    |
| Bold            | `FontWeight.w700`    |
| Extra Bold      | `FontWeight.w800`    |

*/


