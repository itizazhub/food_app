import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/categories/presentation/providers/categories_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/screens/on_boarding_screen1.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/favorites/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/ratings/presentation/providers/rating_provider.dart';
import 'package:food_app/features/recommended/presentation/providers/recommendeds_provider.dart';

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  Future<void> _login() async {
    final notifier = ref.read(authUserNotifierProvider.notifier);
    final state = ref.read(authUserNotifierProvider);

    if (!widget.formKey.currentState!.validate()) return;

    widget.formKey.currentState!.save();

    if (state.username != null && state.password != null) {
      await notifier.login(
        username: state.username!,
        password: state.password!,
      );
    }

    final updatedState = ref.read(authUserNotifierProvider);

    if (updatedState.user != null) {
      ref.watch(categoriesNotifierProvider.notifier).getCategories();
      ref.watch(bestSellersNotifierProvider.notifier).getBestSellers();
      ref.watch(recommendedNotifierProvider.notifier).getRecommendedProducts();
      ref
          .watch(favoriteNotifierProvider.notifier)
          .getUserFavorite(user: updatedState.user!);
      ref
          .watch(addressNotifierProvider.notifier)
          .getUserAddresses(user: updatedState.user!);
      ref
          .watch(orderNotifierProvider.notifier)
          .getUserOrders(user: updatedState.user!);

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
          ? SizedBox(
              height: AppSizedBoxHeights.height20,
              width: AppSizedBoxWidths.width20,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              'Log In',
              style: AppTextStyles.textButtonTextStyle2,
            ),
    );
  }
}
