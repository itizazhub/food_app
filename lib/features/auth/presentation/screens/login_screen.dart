import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/auth/presentation/widgets/login_button.dart';
import 'package:food_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:food_app/features/core/constants/sizes.dart';

import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.read(authUserNotifierProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.yellowDark, // removes transparency
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.fontLight,
        resizeToAvoidBottomInset: true, // Ensure UI adjusts with keyboard
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: const BoxDecoration(
                  color: AppColors.yellowDark,
                ),
                height: 170.h,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 44.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SecondSplashScreen()),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/back-arrow-icons/back-arrow-icon.svg',
                            width: 4,
                            height: 9,
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

            // Bottom section with rounded corners
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
                // Adjust height to avoid overlap with keyboard
                padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 35.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: authUserState.logInFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: AppTextStyles.textStyleAppBodyTitle1,
                        ),
                        SizedBox(height: 17.h),

                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          style: AppTextStyles.textStyleParagraph2,
                        ),
                        SizedBox(height: 38.h),

                        Text(
                          "Username",
                          style: AppTextStyles.textStyleAppBodyTitle2,
                        ),

                        TextFormField(
                            // obscureText: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter username'
                                : null,
                            onChanged: (value) =>
                                authUserState.username = value.trim(),
                            onSaved: (value) =>
                                authUserState.username = value!.trim(),
                            decoration: TextFormFieldStyles.appInputDecoration(
                                hintText: "Enter Username"),
                            style: GoogleFonts.leagueSpartan(
                              color: AppColors.fontDark,
                              fontSize: AppFontSizes.fontSize2,
                              fontWeight: AppFontWeights.regular,
                            )),

                        SizedBox(height: 10.h),

                        Text(
                          "Password",
                          style: AppTextStyles.textStyleAppBodyTitle2,
                        ),

                        const PasswordTextFormField(),

                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: null,
                              style: AppTextButtonStyles.textButtonStyle4,
                              child: Text(
                                'Forgot Password',
                                style: AppTextStyles.textButtonTextStyle3,
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 60.h),

                        // Next Button
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const LoginButton(),
                              SizedBox(height: 30.h),
                              Text(
                                "or sign up with",
                                style: AppTextStyles.textStyleParagraph2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/social-media-icons/GoogleIcon.svg",
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/social-media-icons/FacebookIcon.svg",
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/social-media-icons/FingerprintIcon.svg",
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
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
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r), // Round top-left corner
            topRight: Radius.circular(30.r), // Round top-right corner
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.orangeDark,
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/bottom-navigation-icons/home.svg",
                    width: 25.w,
                    height: 22.h,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/bottom-navigation-icons/categories.svg",
                    width: 25.w,
                    height: 22.h,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/bottom-navigation-icons/favorites.svg",
                    width: 25.w,
                    height: 22.h,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/bottom-navigation-icons/list.svg",
                    width: 25.w,
                    height: 22.h,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/bottom-navigation-icons/help.svg",
                    width: 25.w,
                    height: 22.h,
                  ),
                  label: "")
            ],
          ),
        ),
      ),
    );
  }
}
