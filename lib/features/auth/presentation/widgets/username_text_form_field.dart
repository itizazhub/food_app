import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/core/theme/text_form_field_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

class UsernameTextFormField extends ConsumerWidget {
  const UsernameTextFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.read(authUserNotifierProvider);
    return TextFormField(
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter username' : null,
      onChanged: (value) => authUserState.username = value.trim(),
      onSaved: (value) => authUserState.username = value!.trim(),
      decoration:
          TextFormFieldStyles.appInputDecoration(hintText: "Enter username"),
      style: AppTextStyles.input,
    );
  }
}
