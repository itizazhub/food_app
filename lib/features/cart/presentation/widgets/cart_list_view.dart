import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:intl/intl.dart';

class CartListView extends ConsumerStatefulWidget {
  const CartListView({super.key});

  @override
  ConsumerState<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends ConsumerState<CartListView> {
  String getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    final cartItems = cart?.items ?? [];

    if (cartItems.isEmpty) {
      return const Center(child: Text("Your cart is empty"));
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];

          return Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 248, 248, 248),
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
                        Text(item.productId), // Ideally replace with item.name
                        Text("\$${item.price.toStringAsFixed(2)}"),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(getCurrentFormattedDate()),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartNotifier
                                    .decreaseItemQuantity(item.productId);
                              },
                              child: const CircleAvatar(
                                radius: 7.5,
                                backgroundColor:
                                    Color.fromARGB(180, 168, 121, 93),
                                child: Icon(
                                  Icons.remove,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text("${item.quantity}"),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                cartNotifier.addItemToCart(
                                    cartItem: item, maxQuantity: 5);
                              },
                              child: const CircleAvatar(
                                radius: 7.5,
                                backgroundColor:
                                    Color.fromARGB(180, 209, 91, 22),
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.white,
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
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
