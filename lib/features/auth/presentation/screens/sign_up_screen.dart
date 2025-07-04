import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/auth/presentation/widgets/confirm_password_text_field.dart';
import 'package:food_app/features/auth/presentation/widgets/email_text_form_field.dart';
import 'package:food_app/features/auth/presentation/widgets/label.dart';
import 'package:food_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:food_app/features/auth/presentation/widgets/sign_up_button.dart';
import 'package:food_app/features/auth/presentation/widgets/social_media_icon.dart';
import 'package:food_app/features/auth/presentation/widgets/username_text_form_field.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/screens/splash_screen2.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: true, // Ensure UI adjusts with keyboard
      body: SafeArea(
        child: Stack(
          children: [
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
                          "New Account",
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
                          label("Username"),
                          const UsernameTextFormField(),
                          SizedBox(height: AppSizedBoxHeights.height10),
                          label("Email"),
                          const EmailTextFormField(),
                          SizedBox(height: AppSizedBoxHeights.height10),
                          label("Password"),
                          const PasswordTextFormField(),
                          SizedBox(height: AppSizedBoxHeights.height10),
                          label("Confirm Password"),
                          const ConfirmPasswordTextField(),
                          SizedBox(height: AppSizedBoxHeights.height30),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "By continuing, you agree to ",
                                  style: AppTextStyles.textStyleParagraph5,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  TextButton(
                                    onPressed: null,
                                    style: AppTextButtonStyles.textButtonStyle4,
                                    child: Text(
                                      'Terms of Use',
                                      style: AppTextStyles.textButtonTextStyle3,
                                    ),
                                  ),
                                  Text(
                                    " and ",
                                    style: AppTextStyles.textStyleParagraph5,
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    style: AppTextButtonStyles.textButtonStyle4,
                                    child: Text(
                                      'Privacy Policy',
                                      style: AppTextStyles.textButtonTextStyle3,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSizedBoxHeights.height5),
                          Align(
                            alignment: Alignment.center,
                            child: Column(children: [
                              SignUpButton(formKey: formKey),
                              SizedBox(height: AppSizedBoxHeights.height10),
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
                              SizedBox(height: AppSizedBoxHeights.height10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: AppTextStyles.textStyleParagraph2,
                                    ),
                                    TextButton(
                                      onPressed: null,
                                      style:
                                          AppTextButtonStyles.textButtonStyle4,
                                      child: Text(
                                        'SignUp',
                                        style:
                                            AppTextStyles.textButtonTextStyle4,
                                      ),
                                    ),
                                  ]),
                            ]),
                          )
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
            items: [
              item("assets/bottom-navigation-icons/home.svg"),
              item("assets/bottom-navigation-icons/categories.svg"),
              item("assets/bottom-navigation-icons/favorites.svg"),
              item("assets/bottom-navigation-icons/list.svg"),
              item("assets/bottom-navigation-icons/help.svg"),
            ]),
      ),
    );
  }
}
