import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

Widget btnAddUpdateImage({
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
            icon: Icon(
              Icons.image,
              color: ColorCustom().blueLight,
            ),
          ),
        ),
      ),
    );
