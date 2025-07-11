import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
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
    this.callBack,
    this.isLoading = false,
  });

  final String text;
  final double widht;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color foregroundcolor;
  final double horizental;
  final double vertical;
  final bool isLoading;

  /// Nullable async callback
  final Future<void> Function()? callBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widht,
      height: height,
      child: FilledButton(
        onPressed: callBack == null
            ? null
            : () async {
                await callBack!();
              },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
          foregroundColor: WidgetStateProperty.all<Color>(foregroundcolor),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: GoogleFonts.leagueSpartan(
                  color: foregroundcolor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
      ),
    );
  }
}




//  SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: TextButton(
//                         onPressed: () {
//                           // your logic
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero, // no internal padding
//                           backgroundColor: Colors.orange, // filled background
//                           minimumSize: Size.zero, // prevent default min size
//                           tapTargetSize: MaterialTapTargetSize
//                               .shrinkWrap, // compact touch area
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(4), // optional rounding
//                           ),
//                         ),
//                         child: Text(
//                           'Go',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),