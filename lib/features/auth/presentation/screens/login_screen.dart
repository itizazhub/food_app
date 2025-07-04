import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:food_app/features/auth/presentation/widgets/label.dart';
import 'package:food_app/features/auth/presentation/widgets/login_button.dart';
import 'package:food_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:food_app/features/auth/presentation/widgets/social_media_icon.dart';
import 'package:food_app/features/auth/presentation/widgets/username_text_form_field.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/screens/splash_screen2.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    statusBarBackgroundColor();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.fontLight,
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppHorizentalPaddingds.padding32),
              decoration: const BoxDecoration(
                color: AppColors.yellowDark,
              ),
              height: AppContainerHeights.height170,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizedBoxHeights.height45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen2()),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/back-arrow-icons/back-arrow-icon.svg',
                          width: AppSvgWidths.width4,
                          height: AppSvgHeights.height9,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Log In",
                        style: AppTextStyles.textStyleAppBarTitle,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 114.h,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadiuses.radius30),
                  topRight: Radius.circular(AppRadiuses.radius30),
                ),
                color: AppColors.fontLight,
              ),
              padding: EdgeInsets.only(
                  left: AppHorizentalPaddingds.padding32,
                  right: AppHorizentalPaddingds.padding32,
                  top: AppVerticalPaddingds.padding35),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: AppTextStyles.textStyleAppBodyTitle1,
                        ),
                        SizedBox(height: AppSizedBoxHeights.height16),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          style: AppTextStyles.textStyleParagraph2,
                        ),
                        SizedBox(height: AppSizedBoxHeights.height35),
                        label("Username"),
                        const UsernameTextFormField(),
                        SizedBox(height: AppSizedBoxHeights.height10),
                        label("Password"),
                        const PasswordTextFormField(),
                        SizedBox(height: AppSizedBoxHeights.height10),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ForgotPasswordButton(),
                            ]),

                        SizedBox(height: AppSizedBoxHeights.height60),

                        // Next Button
                        Align(
                          alignment: Alignment.center,
                          child: Column(children: [
                            LoginButton(formKey: formKey),
                            SizedBox(height: AppSizedBoxHeights.height30),
                            Text(
                              "or sign up with",
                              style: AppTextStyles.textStyleParagraph2,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialMediaIcon(
                                      path:
                                          "assets/social-media-icons/GoogleIcon.svg"),
                                  SizedBox(width: AppSizedBoxWidths.width5),
                                  SocialMediaIcon(
                                      path:
                                          "assets/social-media-icons/FacebookIcon.svg"),
                                  SizedBox(width: AppSizedBoxWidths.width5),
                                  SocialMediaIcon(
                                      path:
                                          "assets/social-media-icons/FingerprintIcon.svg"),
                                ]),
                            SizedBox(height: AppSizedBoxHeights.height20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don’t have an account? ",
                                    style: AppTextStyles.textStyleParagraph2,
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    style: AppTextButtonStyles.textButtonStyle4,
                                    child: Text(
                                      'SignUp',
                                      style: AppTextStyles.textButtonTextStyle4,
                                    ),
                                  ),
                                ]),
                          ]),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadiuses.radius30),
            topRight: Radius.circular(AppRadiuses.radius30),
          ),
          child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: AppColors.orangeDark,
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              items: [
                item("assets/bottom-navigation-icons/home.svg"),
                item("assets/bottom-navigation-icons/categories.svg"),
                item("assets/bottom-navigation-icons/favorites.svg"),
                item("assets/bottom-navigation-icons/list.svg"),
                item("assets/bottom-navigation-icons/help.svg"),
              ]),
        ),
      ),
    );
  }
}
