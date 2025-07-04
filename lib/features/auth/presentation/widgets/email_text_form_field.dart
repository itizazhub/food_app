import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class EmailTextFormField extends ConsumerStatefulWidget {
  const EmailTextFormField({super.key});

  @override
  ConsumerState<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends ConsumerState<EmailTextFormField> {
  @override
  Widget build(BuildContext context) {
    final authUserState = ref.read(authUserNotifierProvider);
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email is required';
        }

        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value.trim())) {
          return 'Enter a valid email address';
        }

        return null;
      },
      onChanged: (value) => authUserState.email = value.trim(),
      onSaved: (value) => authUserState.email = value!.trim(),
      decoration: TextFormFieldStyles.appInputDecoration(
        hintText: "user@gmail.com",
      ),
      style: AppTextStyles.input,
    );
  }
}
