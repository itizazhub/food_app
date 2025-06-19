import 'package:flutter/material.dart';

void showRightDrawer({
  required BuildContext context,
  required Widget child,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'RightDrawer',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) => Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 233, 83, 34),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        width: MediaQuery.of(context).size.width * 0.75,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Material(
          color: const Color.fromARGB(255, 233, 83, 34),
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
