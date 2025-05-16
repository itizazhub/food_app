import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.width = 200,
    this.height = 26,
    this.fontSize = 12,
    this.radius = 30,
    this.fontColor = const Color.fromARGB(255, 57, 23, 19),
    this.background = const Color.fromARGB(255, 243, 233, 181),
    this.suffixIcon = const Icon(Icons.person),
    this.suffixIconBool = false,
    this.obscure = false,
    this.validator,
    this.controller,
    this.hintText,
  });

  final double width;
  final double height;
  final double fontSize;
  final double radius;
  final Color background;
  final Color fontColor;
  final Icon suffixIcon;
  final bool suffixIconBool;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      // height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: GoogleFonts.leagueSpartan(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: fontColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          fillColor: background,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.leagueSpartan(
            fontSize: fontSize,
            color: fontColor.withOpacity(0.5),
          ),
          suffixIcon: suffixIconBool ? suffixIcon : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: background,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: background,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: background,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
