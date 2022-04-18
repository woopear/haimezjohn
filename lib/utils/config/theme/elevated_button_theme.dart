import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// dark
final elevatedButtonDark = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.openSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
      const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 20.0,
      ),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  ),
);

/// claire
final elevatedButtonClaire = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: MaterialStateProperty.all<double?>(0.0),
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.openSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
      const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 20.0,
      ),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  ),
);