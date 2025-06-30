import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/on_boarding_screen.dart';
import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isObscured = true;

  bool _isLoading = false;

  int _currentIndex = 0;

  void _navigateToSplashPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    await ref.read(authUserNotifierProvider.notifier).login(
          username: _username,
          password: _password,
        );

    setState(() => _isLoading = false);

    final user = ref.watch(authUserNotifierProvider);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome, ${user.username}!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed. Please try again.")),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.yellowDark, // removes transparency
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
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
                    topLeft: Radius.circular(AppRadiuses.radius2),
                    topRight: Radius.circular(AppRadiuses.radius2),
                  ),
                  color: AppColors.fontLight,
                ),
                // Adjust height to avoid overlap with keyboard
                padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 35.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                            onChanged: (value) => _username = value.trim(),
                            onSaved: (value) => _username = value!.trim(),
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

                        TextFormField(
                          obscureText: _isObscured,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter password'
                              : null,
                          onChanged: (value) => _password = value.trim(),
                          onSaved: (value) => _password = value!.trim(),
                          decoration: TextFormFieldStyles.appInputDecoration(
                            hintText: "Enter Password",
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                              child: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20.0,
                                color: AppColors.orangeDark,
                              ),
                            ),
                          ),
                          style: AppTextStyles.input,
                        ),

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
                              TextButton(
                                onPressed: _login,
                                style: AppTextButtonStyles.textButtonStyle3,
                                child: Text(
                                  'Log In',
                                  style: AppTextStyles.textButtonTextStyle2,
                                ),
                              ),
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
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
