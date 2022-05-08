import 'package:flutter/material.dart';

Widget sideMenutitle({
  required String text,
  TextAlign textAlign = TextAlign.center,
}) =>
    Container(
      width: 250,
      margin: const EdgeInsets.only(top: 50, bottom: 70.0),
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
