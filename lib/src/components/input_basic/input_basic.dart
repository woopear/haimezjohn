import 'package:flutter/material.dart';

Widget inputBasic({
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 20.0),
  int? maxLines = 1,
  EdgeInsetsGeometry? padding,
  String? initialValue,
  TextEditingController? controller,
  String? labelText,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  String? hintText,
  String? errorText
}) => Container(
      margin: margin,
      padding: padding,
      child: TextFormField(
        style: const TextStyle().copyWith(fontSize: 20.0),
        maxLines: maxLines,
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );