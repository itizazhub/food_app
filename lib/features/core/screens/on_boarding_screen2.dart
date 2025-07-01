import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/screens/on_boarding_screen3.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    statusBarBackgroundColor();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            backgroundImage(context),
            skipButton(context),
            bottomContainer(context),
          ],
        ),
      ),
    );
  }

  Widget backgroundImage(BuildContext context) {
    return Positioned(
      top: 0,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/dessert-images/2.jpg", fit: BoxFit.cover)),
    );
  }

  Widget skipButton(BuildContext context) {
    return Positioned(
      right: AppHorizentalPaddingds.padding35,
      top: AppVerticalPaddingds.padding25,
      child: TextButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())),
        style: AppTextButtonStyles.textButtonStyle4,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Skip',
            style: AppTextStyles.textButtonTextStyle3,
          ),
          SizedBox(width: AppSizedBoxWidths.width5),
          SvgPicture.asset(
            "assets/forward-arrow-icons/forward-arrow-icon.svg",
            width: AppSvgWidths.width8,
            height: AppSvgHeights.height12,
          )
        ]),
      ),
    );
  }

  Widget bottomContainer(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: AppHorizentalPaddingds.padding70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadiuses.radius20),
              topRight: Radius.circular(AppRadiuses.radius20)),
          color: AppColors.fontLight,
        ),
        height: AppContainerHeights.height340,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSizedBoxHeights.height23),
            SvgPicture.asset(
              "assets/card-icon.svg",
              width: AppSvgWidths.width30,
              height: AppSvgHeights.height36,
            ),
            SizedBox(height: AppSizedBoxHeights.height23),
            Text(
              "Easy Payment",
              style: AppTextStyles.textStyleAppBodyTitle3,
            ),
            SizedBox(height: AppSizedBoxHeights.height20),
            Text(
                textAlign: TextAlign.center,
                "Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                style: AppTextStyles.textStyleParagraph4),
            SizedBox(height: AppSizedBoxHeights.height30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              container(color: AppColors.yellowLight),
              SizedBox(width: AppSizedBoxWidths.width5),
              container(color: AppColors.orangeDark),
              SizedBox(width: AppSizedBoxWidths.width5),
              container(color: AppColors.yellowLight),
            ]),
            SizedBox(height: AppSizedBoxHeights.height32),
            nextButton(context),
          ],
        ),
      ),
    );
  }

  Widget container({required Color color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppRadiuses.radius12)),
        color: color,
      ),
      height: AppContainerHeights.height5,
      width: AppContainerWidths.width20,
    );
  }

  Widget nextButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen3())),
      style: AppTextButtonStyles.textButtonStyle5,
      child: Text(
        'Next',
        style: AppTextStyles.textButtonTextStyle5,
      ),
    );
  }
}
