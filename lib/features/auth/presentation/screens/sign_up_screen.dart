import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/screens/on_boarding_screen.dart';
import 'package:food_app/features/core/screens/second_splash_screen.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/core/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  int _currentIndex = 0;
  Future<void> _navigateToOnBoardingPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnBoardingScreen()),
    );
  }

  void _navigateToSplashPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondSplashScreen()),
    );
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await ref.watch(authUserNotifierProvider.notifier).signup(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          email: _emailController.text.trim(),
        );

    setState(() => _isLoading = false);

    final user = ref.watch(authUserNotifierProvider);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoardingScreen()),
      );
      print("Email: ${user.email}");
      print("ID: ${user.id}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome, ${user.username}!")),
      );

      // Navigate to another screen if needed
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User already exists. Please login.")),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 203, 88),
                ),
                height: 125,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _navigateToSplashPage,
                      icon: const Icon(
                        size: 18,
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 233, 83, 34),
                      ),
                    ),
                    Text(
                      "New Account",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 248, 248, 248),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),

            // Bottom section with rounded corners
            Positioned(
              top: 110,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
                // Adjust height to avoid overlap with keyboard
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 57, 23, 19),
                          ),
                        ),
                        // Email TextField
                        CustomTextFormField(
                          background: const Color.fromARGB(255, 243, 233, 181),
                          radius: 12,
                          width: double.infinity,
                          fontSize: 20,
                          controller: _usernameController,
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
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 57, 23, 19),
                          ),
                        ),

                        // Password TextField
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
                        const SizedBox(height: 10),
                        Text(
                          "Email",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 57, 23, 19),
                          ),
                        ),
                        CustomTextFormField(
                          background: const Color.fromARGB(255, 243, 233, 181),
                          radius: 12,
                          width: double.infinity,
                          fontSize: 20,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }

                            final email = value.trim();

                            // Simple email regex
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(email)) {
                              return 'Enter a valid email address';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 10),

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
                                text: "Sign Up",
                                callBack: _isLoading ? null : _signup,
                                isLoading: _isLoading,
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
                                    "social-media-icons/GoogleIcon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset(
                                    "social-media-icons/FacebookIcon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset(
                                    "social-media-icons/FingerprintIcon.svg",
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
        borderRadius: const BorderRadius.only(
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
                  "bottom-navigation-icons/home.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/categories.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/favorites.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/list.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/help.svg",
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}
