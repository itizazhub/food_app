import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/on_boarding_screen3.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.yellowDark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/dessert-images/1.jpg",
                      fit: BoxFit.cover)),
            ),
            Positioned(
              right: 35.w,
              top: 25.h,
              child: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                style: AppTextButtonStyles.textButtonStyle4,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Skip',
                    style: AppTextStyles.textButtonTextStyle3,
                  ),
                  SizedBox(width: 5.w),
                  SvgPicture.asset(
                    "assets/forward-arrow-icons/forward-arrow-icon.svg",
                    width: 8.w,
                    height: 13.h,
                  )
                ]),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                  color: AppColors.fontLight,
                ),
                height: 338.h,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 23.h),
                    SvgPicture.asset(
                      "assets/card-icon.svg",
                      width: 30.w,
                      height: 36.h,
                    ),
                    SizedBox(height: 23.h),
                    Text(
                      "Easy Payment",
                      style: AppTextStyles.textStyleAppBodyTitle3,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                        textAlign: TextAlign.center,
                        "Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                        style: AppTextStyles.textStyleParagraph4),
                    SizedBox(height: 30.h),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: AppColors.yellowLight,
                        ),
                        height: 4.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: AppColors.orangeDark,
                        ),
                        height: 4.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          color: AppColors.yellowLight,
                        ),
                        height: 4.h,
                        width: 20.w,
                      )
                    ]),
                    SizedBox(height: 32.h),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnBoardingScreen3())),
                      style: AppTextButtonStyles.textButtonStyle5,
                      child: Text(
                        'Next',
                        style: AppTextStyles.textButtonTextStyle5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
