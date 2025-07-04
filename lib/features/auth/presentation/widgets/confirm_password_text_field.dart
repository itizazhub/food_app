import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class ConfirmPasswordTextField extends ConsumerStatefulWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  ConsumerState<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState
    extends ConsumerState<ConfirmPasswordTextField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    final authUserState = ref.read(authUserNotifierProvider);
    return TextFormField(
      obscureText: _isObscured,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Re-enter password';
        }
        if (authUserState.confirmPassword != authUserState.password) {
          return 'Passwords do not match';
        }

        return null;
      },
      onChanged: (value) => authUserState.confirmPassword = value.trim(),
      onSaved: (value) => authUserState.confirmPassword = value!.trim(),
      decoration: TextFormFieldStyles.appInputDecoration(
        hintText: "Re-enter password",
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
