import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIcon extends StatelessWidget {
  CustomIcon({
    super.key,
    this.width = 26,
    this.height = 26,
    this.padding = 3,
    this.radius = 9,
    this.background = const Color.fromARGB(255, 243, 233, 181),
    this.path = "",
    this.label = "",
  });

  double width;
  double height;
  double padding;
  double radius;
  Color background;
  String path;
  String label;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) {
      return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
        ),
        child: SvgPicture.asset(
          path,
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: background,
            ),
            child: SvgPicture.asset(
              path,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.leagueSpartan(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 57, 23, 19),
            ),
          ),
        ],
      );
    }
  }
}
