import 'package:flutter/material.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      style: AppTextButtonStyles.textButtonStyle4,
      child: Text(
        'Forgot Password',
        style: AppTextStyles.textButtonTextStyle3,
      ),
    );
  }
}
