import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/screens/on_boarding_screen.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  Future<void> _login() async {
    final notifier = ref.read(authUserNotifierProvider.notifier);
    final state = ref.read(authUserNotifierProvider);

    final formKey = state.logInFormKey;

    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    // Check if username and password are filled
    if (state.username != null && state.password != null) {
      await notifier.login(
        username: state.username!,
        password: state.password!,
      );
    }

    final updatedState =
        ref.read(authUserNotifierProvider); // Re-read after login

    if (updatedState.user != null) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome, ${updatedState.user!.username}!")),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authUserNotifierProvider);

    return TextButton(
      onPressed: state.isLoading ? null : _login,
      style: AppTextButtonStyles.textButtonStyle3,
      child: state.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              'Log In',
              style: AppTextStyles.textButtonTextStyle2,
            ),
    );
  }
}
