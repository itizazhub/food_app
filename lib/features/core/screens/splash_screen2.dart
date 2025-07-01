import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeDark,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSizedBoxHeights.height255),
            logo(),
            SizedBox(height: AppSizedBoxHeights.height30),
            SizedBox(
                width: AppSizedBoxWidths.width300,
                child: Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
                  style: AppTextStyles.textStyleParagraph1,
                )),
            SizedBox(height: AppSizedBoxHeights.height40),
            logInTextButton(context),
            SizedBox(height: AppSizedBoxHeights.height5),
            signUpTextButton(context),
            SizedBox(height: AppSizedBoxHeights.height120),
          ],
        ),
      ),
    );
  }

  Widget signUpTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
      style: AppTextButtonStyles.textButtonStyle2,
      child: Text(
        'Sign Up',
        style: AppTextStyles.textButtonTextStyle1,
      ),
    );
  }

  Widget logInTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      style: AppTextButtonStyles.textButtonStyle1,
      child: Text(
        'Log In',
        style: AppTextStyles.textButtonTextStyle1,
      ),
    );
  }

  Widget logo() {
    return Column(
      children: [
        SvgPicture.asset(
          color: AppColors.yellowDark,
          "assets/logo-icons/logo.svg",
          width: AppSvgWidths.width200,
          height: AppSvgHeights.height180,
        ),
        SizedBox(height: AppSizedBoxHeights.height26),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("YUM", style: AppTextStyles.textStyleLogoPart2),
            Text("QUICK", style: AppTextStyles.textStyleLogoPart3),
          ],
        ),
      ],
    );
  }
}
