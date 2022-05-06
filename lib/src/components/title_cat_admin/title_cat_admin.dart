import 'package:flutter/material.dart';

Widget titleCatAdmin({
  required String text,
  required BuildContext context,
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 20.0),
  EdgeInsetsGeometry? padding,
}) =>
    Container(
      margin: margin,
      padding: padding,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );
