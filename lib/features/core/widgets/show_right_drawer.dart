import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/core/constants/sizes.dart';

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
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.orangeDark,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  bottomLeft: Radius.circular(40.r))),
          width: 330.w,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: AppHorizentalPaddingds.padding32),
          child: Material(
            color: AppColors.orangeDark,
            child: child,
          ),
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
