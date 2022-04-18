import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textButtonStyleDark = ButtonStyle(
  overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
  textStyle: MaterialStateProperty.all<TextStyle?>(
    GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
  ),
);

final textButtonStyleClaire = ButtonStyle(
  overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
  textStyle: MaterialStateProperty.all<TextStyle?>(
    GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
  ),
);

