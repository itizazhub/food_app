import 'package:flutter/material.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

Widget cartDrawer() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        leading: const Icon(Icons.shopping_cart),
        title: Text(
          "Cart",
          style: AppTextStyles.textStyleAppBarTitle3,
        ),
      ),
      const Divider(),
      Expanded(
        child: ListView(
          children: [
            ListTile(title: Text("Item 1"), trailing: Text("x2")),
            ListTile(title: Text("Item 2"), trailing: Text("x1")),
          ],
        ),
      ),
    ],
  );
}
