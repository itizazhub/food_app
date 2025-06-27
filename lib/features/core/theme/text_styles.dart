import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final textStyleLogoPart1 = GoogleFonts.poppins(
      color: const Color.fromARGB(255, 233, 83, 34),
      fontSize: 34,
      fontWeight: FontWeight.w800);

  static final textStyleLogoPart2 = GoogleFonts.poppins(
      color: const Color.fromARGB(255, 245, 203, 88),
      fontSize: 34,
      fontWeight: FontWeight.w800);
  static final textStyleLogoPart3 = GoogleFonts.poppins(
      color: const Color.fromARGB(255, 248, 248, 248),
      fontSize: 34,
      fontWeight: FontWeight.w800);
}

final TextTheme textStyles =
    TextTheme(displayLarge: TextStyles.textStyleLogoPart1);



/*
| Figma Font Name | Flutter `FontWeight` |
| --------------- | -------------------- |
| Extra Light     | `FontWeight.w200`    |
| Light           | `FontWeight.w300`    |
| Regular         | `FontWeight.w400`    |
| Medium          | `FontWeight.w500`    |
| Semi Bold       | `FontWeight.w600`    |
| Bold            | `FontWeight.w700`    |
| Extra Bold      | `FontWeight.w800`    |

*/


