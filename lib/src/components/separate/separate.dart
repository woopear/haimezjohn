import 'package:flutter/material.dart';

Widget separate({
  required Color colorSeparate,
  double heighTop = 20.0,
  double heighBottom = 20.0,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: heighTop,
      bottom: heighBottom,
    ),
    child: Divider(
      color: colorSeparate,
    ),
  );
}
