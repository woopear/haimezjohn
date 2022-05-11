import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

Widget btnElevated({
  required void Function()? onPressed,
  required String text,
  bool isLoading = false,
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 20.0),
  AlignmentGeometry alignment = Alignment.centerRight,
  EdgeInsetsGeometry? padding,
  double? fontSize,
}) =>
    Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: padding,
        child: ElevatedButton(
          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator(
                  color: ColorCustom().blue,
                )
              : Text(
            text,
            style: const TextStyle().copyWith(
              fontSize: fontSize,
            ),
          ), 
        ),
      ),
    );
