import 'package:flutter/material.dart';

Widget btnDeleteOne({
  required void Function()? onPressed,
    String? message,
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 20.0),
  AlignmentGeometry alignment = Alignment.center,
  EdgeInsetsGeometry? padding,
}) =>
    Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: padding,
        child: Tooltip(
          message: message,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
