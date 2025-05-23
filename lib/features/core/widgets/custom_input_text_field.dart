import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputTextField extends StatelessWidget {
  CustomInputTextField(
      {super.key,
      this.width = 200,
      this.height = 26,
      this.fontSize = 12,
      this.radius = 30,
      this.fontColor = const Color.fromARGB(255, 57, 23, 19),
      this.background = const Color.fromARGB(255, 243, 233, 181),
      this.suffixIcon = const Icon(Icons.person),
      this.suffixIconBool = false,
      this.obscure = false});

  double width;
  double height;
  double fontSize;
  double radius;
  Color background;
  Color fontColor;
  Icon suffixIcon;
  bool suffixIconBool;
  bool obscure;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width,
      height: height,
      child: TextField(
        obscureText: obscure ? true : false,
        style: GoogleFonts.leagueSpartan(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: fontColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          fillColor: background,
          filled: true,
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
