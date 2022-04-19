import 'package:flutter/material.dart';

Widget labelInput({
  required String text,
  EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 10.0),
  AlignmentGeometry alignment = Alignment.centerLeft,
  EdgeInsetsGeometry? padding,
  FontWeight fontWeight = FontWeight.w700,
}) =>
    Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: padding,
        child: Text(text, style: const TextStyle().copyWith(fontWeight: fontWeight),),
      ),
    );
