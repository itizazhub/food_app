import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
---colors---
yellow 245, 203, 88
light yellow 243, 233, 181
orange 233, 83, 34
light orange 255, 222, 207
font 1 57, 23, 19 darkone
font 2 248, 248, 248 lightone
---font sizes---
paragraph 14 league spartan light
title 24 26 league spartan bold
subtitle 20 league spartan medium 
screen title 28 league spartan bold
*/

class CustomFilledButton extends StatelessWidget {
  CustomFilledButton({
    super.key,
    this.text = "",
    this.widht = 207,
    this.height = 45,
    this.horizental = 8,
    this.vertical = 8,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor = const Color.fromARGB(255, 233, 83, 34),
    this.foregroundcolor = const Color.fromARGB(255, 248, 248, 248),
    required this.callBack,
  });
  String text;
  double widht;
  double height;
  double fontSize;
  FontWeight fontWeight;
  Color backgroundColor;
  Color foregroundcolor;
  double horizental;
  double vertical;
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widht,
      height: height,
      child: FilledButton(
        onPressed: () {
          callBack();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            foregroundcolor,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.leagueSpartan(
              color: foregroundcolor,
              fontSize: fontSize,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
