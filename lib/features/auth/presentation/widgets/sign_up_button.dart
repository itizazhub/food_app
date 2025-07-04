import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/on_boarding_screen1.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class SignUpButton extends ConsumerStatefulWidget {
  const SignUpButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  Future<void> _signUp() async {
    final state = ref.read(authUserNotifierProvider);
    final formKey = widget.formKey;
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    if (state.username != null &&
        state.password != null &&
        state.email != null) {
      await ref.read(authUserNotifierProvider.notifier).signup(
            username: state.username!,
            password: state.password!,
            email: state.email!,
          );
    }

    final updatedState = ref.read(authUserNotifierProvider);

    if (updatedState.user != null) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen1()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome, ${updatedState.user!.username}!")),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authUserNotifierProvider);

    return TextButton(
      onPressed: state.isLoading ? null : _signUp,
      style: AppTextButtonStyles.textButtonStyle3,
      child: state.isLoading
          ? SizedBox(
              height: AppSizedBoxHeights.height20,
              width: AppSizedBoxWidths.width20,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              'Sign Up',
              style: AppTextStyles.textButtonTextStyle2,
            ),
    );
  }
}
