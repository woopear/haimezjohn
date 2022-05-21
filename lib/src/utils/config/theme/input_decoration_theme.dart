import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

final inputDecorationDark = InputDecorationTheme(
  isDense: true,
  contentPadding:
      const EdgeInsets.only(top: 20.0, bottom: 15.0, left: 30.0, right: 20.0),
  isCollapsed: true,
  filled: true,
  fillColor: ColorCustom().inputDark,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

const inputDecorationClaire = InputDecorationTheme(
  isDense: true,
  contentPadding:
      EdgeInsets.only(top: 20.0, bottom: 15.0, left: 30.0, right: 20.0),
  isCollapsed: true,
  filled: true,
  hoverColor: Color.fromARGB(255, 255, 242, 218),
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);
