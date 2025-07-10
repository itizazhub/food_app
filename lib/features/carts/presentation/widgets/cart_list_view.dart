import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/theme/button_styles.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/orders/presentation/screens/confirm_order_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CartListView extends ConsumerStatefulWidget {
  const CartListView({super.key});

  @override
  ConsumerState<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends ConsumerState<CartListView> {
  Future<void> goToconfirmOrderScreen() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ConfirmOrderScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final cartItems = cartState.cart?.items ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cart title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color.fromARGB(255, 233, 83, 34),
                ),
              ),
              SizedBox(width: AppSizedBoxWidths.width5),
              Text("Cart", style: AppTextStyles.textStyleAppBarTitle3),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(color: AppColors.yellowDark),
          Text(
            "You have ${cartItems.length} items in your cart",
            style: AppTextStyles.textStyleAppBodyTitle6,
          ),
          const SizedBox(height: 10),

          if (cartItems.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 32.w),
              child: Center(child: Text("Your cart is empty")),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.yellowDark),
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return Container(
                  width: 255.w,
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
                          height: 80.h,
                          width: 80.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),

                      // Details and delete
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
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
                                style: AppTextStyles.textStyleParagraph9,
                              ),
                            ),
                            // const SizedBox(height: 6),
                            SizedBox(
                              width: AppButtonWidths.width100,
                              height: AppButtonHeights.height26,
                              child: TextButton(
                                onPressed: () => cartNotifier
                                    .removeItemFromCart(cartItem: item),
                                style: AppTextButtonStyles.textButtonStyle6,
                                child: Text(
                                  'Delete',
                                  style: AppTextStyles.textButtonTextStyle7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Price and quantity controls
                      Container(
                        width: 87.w,
                        padding: EdgeInsets.only(left: 8.w.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              getCurrentFormattedDate(),
                              style: AppTextStyles.textStyleParagraph9,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${item.price.toStringAsFixed(2)}",
                              style: AppTextStyles.textStyleParagraph10,
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
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
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
            ),

          SizedBox(height: 20.h),

          // Pricing Summary
          if (cartItems.isNotEmpty) ...[
            _priceRow("Subtotal", cartState.cart!.total),
            _priceRow("Tax and fees", 5.00),
            _priceRow("Delivery", 3.00),
            const Divider(color: AppColors.yellowDark),
            _priceRow("Total", cartState.cart!.total + 8.00),
            const SizedBox(height: 16),
            Center(
              child: CustomFilledButton(
                text: "Checkout",
                height: 38,
                widht: 140,
                fontSize: 20,
                foregroundcolor: const Color.fromARGB(255, 233, 83, 34),
                backgroundColor: Colors.white,
                callBack: goToconfirmOrderScreen,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _priceRow(String title, double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.textStyleAppBodyTitle6,
          ),
          const Spacer(),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: AppTextStyles.textStyleAppBodyTitle6,
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 9,
        backgroundColor: Colors.white,
        child: Icon(icon, size: 14, color: Colors.black),
      ),
    );
  }
}
