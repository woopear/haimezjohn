import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget? smallMobile;

  const Responsive({
    Key? key,
    this.tablet,
    this.smallMobile,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  /// si mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  /// si tablette
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1080 &&
      MediaQuery.of(context).size.width >= 768;

  /// si pc
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1080;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    /// pc
    if (_size.width >= 1080) {
      return desktop;
    }
    /// tablette
    else if (_size.width >= 768 && tablet != null) {
      return tablet!;
    }
    /// mobile ou small mobile
    else if (_size.width >= 376 && _size.width <= 768) {
      return mobile;
    } else {
      return smallMobile!;
    }
  }
}
