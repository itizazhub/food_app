import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/orders/presentation/screens/confirm_order_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    final cartItems = cart?.items ?? [];

    // if (cartItems.isEmpty) {
    //   return const Center(child: Text("Your cart is empty"));
    // }

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 233, 83, 34),
              )),
          Text(
            "Cart",
            style: GoogleFonts.leagueSpartan(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const Divider(color: Colors.white),
      Text(
        "You have ${cartItems.length} items in the cart",
        style: GoogleFonts.leagueSpartan(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 10),
      !cartItems.isEmpty
          ? SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  return Column(
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 233, 83, 34),
                        elevation: 0,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                height: 80,
                                width: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    item.productId,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.leagueSpartan(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ), // Ideally replace with item.name
                                Text(
                                  "\$${item.price.toStringAsFixed(2)}",
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                CustomFilledButton(
                                  text: "Delete",
                                  widht: 116,
                                  height: 26,
                                  fontSize: 15,
                                  foregroundcolor:
                                      const Color.fromARGB(255, 233, 83, 34),
                                  backgroundColor: Colors.white,
                                  callBack: () async {
                                    cartNotifier.removeItemFromCart(
                                        cartItem: item);
                                  },
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  getCurrentFormattedDate(),
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cartNotifier.decreaseItemQuantity(
                                            item.productId);
                                      },
                                      child: const CircleAvatar(
                                        radius: 7.5,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.remove,
                                          size: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${item.quantity}",
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        cartNotifier.addItemToCart(
                                            cartItem: item, maxQuantity: 5);
                                      },
                                      child: const CircleAvatar(
                                        radius: 7.5,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          size: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white),
                    ],
                  );
                },
              ),
            )
          : const Center(child: Text("Your cart is empty")),
      cartItems.length != 0
          ? Row(
              children: [
                Text(
                  "Subtotal",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${ref.watch(cartNotifierProvider)!.total.toStringAsFixed(2)}",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : SizedBox.shrink(),
      cartItems.length != 0
          ? Row(
              children: [
                Text(
                  "Tax and fees",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$5.00",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
      cartItems.length != 0
          ? Row(
              children: [
                Text(
                  "Delivery",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$3.00",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
      cartItems.length != 0
          ? const Divider(color: Colors.white)
          : const SizedBox.shrink(),
      cartItems.length != 0
          ? Row(
              children: [
                Text(
                  "Total",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$${(ref.watch(cartNotifierProvider)!.total + 8).toStringAsFixed(2)}",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
      cartItems.length != 0
          ? CustomFilledButton(
              text: "Checkout",
              height: 36,
              widht: 130,
              fontSize: 20,
              foregroundcolor: const Color.fromARGB(255, 233, 83, 34),
              backgroundColor: Colors.white,
              callBack: goToconfirmOrderScreen,
            )
          : const SizedBox.shrink(),
    ]);
  }
}
