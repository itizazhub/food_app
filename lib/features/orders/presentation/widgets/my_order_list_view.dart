import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/orders/domain/entities/order.dart';
import 'package:food_app/features/reviews/presentation/screens/review_screen.dart';

class MyOrderListView extends ConsumerStatefulWidget {
  MyOrderListView({super.key, required this.order});
  Order order;

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
        itemCount: widget.order.items.length,
        itemBuilder: (context, index) {
          final item = widget.order.items[index];
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
                        Text(
                            "${item.productId}"), // Ideally replace with item.name
                        Text("\$${item.price.toStringAsFixed(2)}"),
                        widget.order.orderStatus != "-OPVnopZWgoqB8b3oK8I"
                            ? CustomFilledButton(
                                text: "Leave a review",
                                widht: 145,
                                height: 26,
                                horizental: 0.0,
                                fontSize: 15,
                                callBack: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ReviewScreen(item: item)));
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(getCurrentFormattedDate()),
                        const SizedBox(height: 4),
                        Text("${widget.order.items.length.toString()} items"),
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
