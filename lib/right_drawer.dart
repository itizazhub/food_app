import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RightDrawer extends StatefulWidget {
  const RightDrawer({super.key});

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () {
            showRightDrawer(context: context, child: cartDrawer());
          },
          child: Text("click me")),
    );
  }

  void showRightDrawer({
    required BuildContext context,
    required Widget child,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'RightDrawer',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          width: MediaQuery.of(context).size.width * 0.75,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.amber,
            child: child,
          ),
        ),
      ),
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  Widget cartDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Your Cart"),
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
}
