import 'package:flutter/material.dart';

class ResponsiveSize {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData != null) {
      screenWidth = _mediaQueryData?.size.width;
      screenHeight = _mediaQueryData?.size.height;
      if (screenWidth != null && screenHeight != null) {
        blockSizeHorizontal = screenWidth! / 100;
        blockSizeVertical = screenHeight! / 100;
      }
    }
  }
}
