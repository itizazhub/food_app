import 'package:flutter/material.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final textStyleLogoPart1 = GoogleFonts.poppins(
    color: AppColors.orangeDark,
    fontSize: AppFontSizes.fontSize6,
    fontWeight: AppFontWeights.extraBold,
    height: 1,
  );

  static final textStyleLogoPart2 = GoogleFonts.poppins(
    color: AppColors.yellowDark,
    fontSize: AppFontSizes.fontSize6,
    fontWeight: AppFontWeights.extraBold,
    height: 1,
  );
  static final textStyleLogoPart3 = GoogleFonts.poppins(
    color: AppColors.fontLight,
    fontSize: AppFontSizes.fontSize6,
    fontWeight: AppFontWeights.extraBold,
    height: 1,
  );

  static final textButtonTextStyle1 = GoogleFonts.leagueSpartan(
    color: AppColors.orangeDark,
    fontSize: AppFontSizes.fontSize3,
    fontWeight: AppFontWeights.medium,
    height: 1,
  );

  static final textButtonTextStyle2 = GoogleFonts.leagueSpartan(
    color: AppColors.fontLight,
    fontSize: AppFontSizes.fontSize3,
    fontWeight: AppFontWeights.medium,
    height: 1,
  );

  static final textButtonTextStyle3 = GoogleFonts.leagueSpartan(
    color: AppColors.orangeDark,
    fontSize: AppFontSizes.fontSize1,
    fontWeight: AppFontWeights.medium,
    height: 1,
  );

  static final textButtonTextStyle4 = GoogleFonts.leagueSpartan(
    color: AppColors.orangeDark,
    fontSize: AppFontSizes.fontSize1,
    fontWeight: AppFontWeights.light,
    height: 1,
  );

  static final textStyleParagraph1 = GoogleFonts.poppins(
    color: AppColors.fontLight,
    fontSize: AppFontSizes.fontSize1,
    fontWeight: AppFontWeights.medium,
    height: 1.1,
  );

  static final textStyleParagraph2 = GoogleFonts.leagueSpartan(
    fontSize: AppFontSizes.fontSize1,
    fontWeight: AppFontWeights.light,
    color: AppColors.fontDark,
    height: 1.1,
  );

  static final textStyleParagraph3 = GoogleFonts.leagueSpartan(
    color: AppColors.fontDark,
    fontSize: AppFontSizes.fontSize0,
    fontWeight: AppFontWeights.light,
    height: 1,
  );

  static final textStyleAppBarTitle = GoogleFonts.leagueSpartan(
    fontSize: AppFontSizes.fontSize5,
    fontWeight: AppFontWeights.bold,
    color: AppColors.fontLight,
    height: 1,
  );

  static final textStyleAppBodyTitle1 = GoogleFonts.leagueSpartan(
      fontSize: AppFontSizes.fontSize3,
      fontWeight: AppFontWeights.semiBold,
      color: AppColors.fontDark,
      height: 1);

  static final textStyleAppBodyTitle2 = GoogleFonts.leagueSpartan(
    fontSize: AppFontSizes.fontSize2,
    fontWeight: AppFontWeights.medium,
    color: AppColors.fontDark,
  );

  static final input = GoogleFonts.leagueSpartan(
    color: AppColors.fontDark,
    fontSize: AppFontSizes.fontSize2,
    fontWeight: AppFontWeights.regular,
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


