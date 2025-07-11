import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class PasswordTextFormField extends ConsumerStatefulWidget {
  const PasswordTextFormField({super.key});

  @override
  ConsumerState<PasswordTextFormField> createState() =>
      _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends ConsumerState<PasswordTextFormField> {
  bool _isObscured = true;
  bool isPasswordStrong(String password) {
    return RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%^&*()_\-=\[\]{};:\"\\|,.<>\/?]).{8,}$')
        .hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final authUserState = ref.read(authUserNotifierProvider);
    return TextFormField(
      obscureText: _isObscured,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter password';
        }
        if (!isPasswordStrong(value)) {
          return 'Password must be 8+ chars, include number, letter, special char';
        }
      },
      onChanged: (value) => authUserState.password = value.trim(),
      onSaved: (value) => authUserState.password = value!.trim(),
      decoration: TextFormFieldStyles.appInputDecoration(
        hintText: "Enter password",
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          child: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
            size: 20.0,
            color: AppColors.orangeDark,
          ),
        ),
      ),
      style: AppTextStyles.input,
    );
  }
}
