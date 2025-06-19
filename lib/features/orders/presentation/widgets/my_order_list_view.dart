import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:intl/intl.dart';

class MyOrderListView extends ConsumerStatefulWidget {
  const MyOrderListView({super.key});

  @override
  ConsumerState<MyOrderListView> createState() => _MyOrderListViewState();
}

class _MyOrderListViewState extends ConsumerState<MyOrderListView> {
  @override
  Widget build(BuildContext context) {
    // final cart = ref.watch(cartNotifierProvider);
    // final cartNotifier = ref.read(cartNotifierProvider.notifier);

    // final cartItems = cart?.items ?? [];

    // if (cartItems.isEmpty) {
    //   return const Center(child: Text("Your cart is empty"));
    // }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
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
                        "drinks-images/1.jpg",
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
                        Text("product name"), // Ideally replace with item.name
                        Text("\$${4.toStringAsFixed(2)}"),
                        CustomFilledButton(
                          text: "Leave a review",
                          widht: 150,
                          height: 26,
                          fontSize: 15,
                          callBack: () async {},
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(getCurrentFormattedDate()),
                        const SizedBox(height: 4),
                        Text("${2} items"),
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
