import 'package:flutter/material.dart';
import 'package:food_app/features/core/constants/sizes.dart';

class AppTextButtonStyles {
  static final textButtonStyle1 = TextButton.styleFrom(
    padding: EdgeInsets.zero, // no internal padding
    backgroundColor: AppColors.yellowDark, // filled background
    fixedSize: Size(AppButtonWidths.width1,
        AppButtonHeights.height1), // prevent default min size
    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // compact touch area
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(AppRadiuses.radius2), // optional rounding
    ),
  );

  static final textButtonStyle2 = TextButton.styleFrom(
    padding: EdgeInsets.zero, // no internal padding
    backgroundColor: AppColors.yellowLight, // filled background
    fixedSize: Size(AppButtonWidths.width1,
        AppButtonHeights.height1), // prevent default min size
    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // compact touch area
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(AppRadiuses.radius2), // optional rounding
    ),
  );

  static final textButtonStyle3 = TextButton.styleFrom(
    padding: EdgeInsets.zero, // no internal padding
    backgroundColor: AppColors.orangeDark, // filled background
    fixedSize: Size(AppButtonWidths.width1,
        AppButtonHeights.height1), // prevent default min size
    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // compact touch area
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(AppRadiuses.radius2), // optional rounding
    ),
  );

  static final textButtonStyle4 = TextButton.styleFrom(
    padding: EdgeInsets.zero, // no internal padding
    backgroundColor: AppColors.fontLight, // filled background
    minimumSize: Size.zero, // prevent default min size
    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // compact touch area
  );
}
