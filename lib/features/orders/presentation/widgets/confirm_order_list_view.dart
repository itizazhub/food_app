import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConfirmOrderListView extends ConsumerStatefulWidget {
  const ConfirmOrderListView({super.key});

  @override
  ConsumerState<ConfirmOrderListView> createState() =>
      _ConfirmOrderListViewState();
}

class _ConfirmOrderListViewState extends ConsumerState<ConfirmOrderListView> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    final cartItems = cartState.cart?.items ?? [];

    if (cartItems.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 32.w),
        child: Center(child: Text("Your cart is empty")),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) =>
            const Divider(color: AppColors.orangeLight),
        itemBuilder: (context, index) {
          final item = cartItems[index];

          return Container(
            width: 324.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    item.imageUrl,
                    height: 90.h,
                    width: 85.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),

                // Details and delete
                Container(
                  padding: EdgeInsets.only(left: 15.w),
                  width: 87.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: Text(
                          item.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.textStyleParagraph9
                              .copyWith(color: AppColors.fontDark),
                        ),
                      ),
                      SizedBox(
                        width: AppButtonWidths.width100,
                        height: AppButtonHeights.height26,
                        child: TextButton(
                          onPressed: () =>
                              cartNotifier.removeItemFromCart(cartItem: item),
                          style: AppTextButtonStyles.textButtonStyle6.copyWith(
                            backgroundColor:
                                WidgetStateProperty.all(AppColors.orangeLight),
                          ),
                          child: Text(
                            'Delete',
                            style: AppTextStyles.textButtonTextStyle7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Price and quantity controls
                Container(
                  width: 87.w,
                  padding: EdgeInsets.only(left: 8.w.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        getCurrentFormattedDate(),
                        style: AppTextStyles.textStyleParagraph9
                            .copyWith(color: AppColors.fontDark),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${item.price.toStringAsFixed(2)}",
                        style: AppTextStyles.textStyleParagraph10
                            .copyWith(color: AppColors.fontDark),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _qtyBtn(
                            icon: Icons.remove,
                            onTap: () => cartNotifier
                                .decreaseItemQuantity(item.productId),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "${item.quantity}",
                            style: AppTextStyles.textStyleParagraph9
                                .copyWith(color: AppColors.fontDark),
                          ),
                          SizedBox(width: 6),
                          _qtyBtn(
                            icon: Icons.add,
                            onTap: () => cartNotifier.addItemToCart(
                                cartItem: item, maxQuantity: 5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 9,
        backgroundColor: AppColors.orangeDark,
        child: Icon(icon, size: 14, color: AppColors.fontLight),
      ),
    );
  }
}
