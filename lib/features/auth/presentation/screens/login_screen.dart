import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/on_boarding_screen.dart';
import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/core/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

    setState(() => _isLoading = true);

    await ref.read(authUserNotifierProvider.notifier).login(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      resizeToAvoidBottomInset: true, // Ensure UI adjusts with keyboard
      body: SafeArea(
        child: Stack(
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
              top: 114,
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
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 35.h),
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
                        CustomTextFormField(
                          controller: _usernameController,
                          background: const Color.fromARGB(255, 243, 233, 181),
                          radius: 12,
                          width: double.infinity,
                          fontSize: 20,
                          validator: (value) {
                            if (value == null ||
                                value.trim().length < 2 ||
                                value.trim().length > 50) {
                              return "Username must be between 2 and 50 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        Text(
                          "Password",
                          style: AppTextStyles.textStyleAppBodyTitle2,
                        ),

                        CustomTextFormField(
                          background: const Color.fromARGB(255, 243, 233, 181),
                          radius: 12,
                          width: double.infinity,
                          fontSize: 20,
                          suffixIcon: const Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 233, 83, 34),
                          ),
                          suffixIconBool: true,
                          obscure: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 5),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 233, 83, 34),
                              ),
                            )),
                        const SizedBox(height: 20),

                        // Next Button
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              CustomFilledButton(
                                text: "Log In",
                                isLoading: _isLoading,
                                callBack: _isLoading ? null : _login,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "or sign up with",
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromARGB(255, 57, 23, 19),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/social-media-icons/GoogleIcon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    "assets/social-media-icons/FacebookIcon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    "assets/social-media-icons/FingerprintIcon.svg",
                                    width: 40,
                                    height: 40,
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
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), // Round top-left corner
          topRight: Radius.circular(12), // Round top-right corner
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromARGB(255, 233, 83, 34),
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
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/bottom-navigation-icons/categories.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/bottom-navigation-icons/favorites.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/bottom-navigation-icons/list.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/bottom-navigation-icons/help.svg",
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}
