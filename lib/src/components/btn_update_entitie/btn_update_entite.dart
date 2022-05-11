import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

Widget btnUpdateEntite({
  required void Function()? onPressed,
  String? message,
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 20.0),
  AlignmentGeometry alignment = Alignment.center,
  EdgeInsetsGeometry? padding,
  bool file = false,
  double iconSize = 30,
}) =>
    Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: padding,
        child: Tooltip(
          message: message,
          child: IconButton(
            iconSize: iconSize,
            onPressed: onPressed,
            icon: Icon(
              file ? Icons.file_download_outlined : Icons.border_color_rounded,
              color: ColorCustom().blueLight,
            ),
          ),
        ),
      ),
    );
