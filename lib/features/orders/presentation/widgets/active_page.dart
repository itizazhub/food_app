import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/orders/presentation/screens/order_details.dart';

class ActivePage extends ConsumerStatefulWidget {
  const ActivePage({super.key});

  @override
  ConsumerState<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends ConsumerState<ActivePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orders = ref.watch(orderNotifierProvider.notifier).activeOrders();

      return ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (_, __) => const Divider(
          color: Color.fromARGB(255, 214, 92, 61),
        ),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT side
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${order.orderId}"),
                      Text("${order.orderDate}"),
                      const SizedBox(height: 8),
                      CustomFilledButton(
                        text: "Cancel",
                        height: 30,
                        widht: 100,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // RIGHT side
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("\$${(order.total).toString()}"),
                      Text("${(order.items.length).toString()} items"),
                      const SizedBox(height: 8),
                      CustomFilledButton(
                        text: "Details",
                        height: 30,
                        widht: 100,
                        fontSize: 14,
                        callBack: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => OrderDetails(
                                orderId: order.orderId,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
