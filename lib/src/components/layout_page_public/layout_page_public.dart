import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget layoutPagePublic({
  required BuildContext context,
  required Widget child,
}) {
  return SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            margin: const EdgeInsets.only(bottom: 70.0),
            width: Responsive.isDesktop(context) ? 950 : double.infinity,
            child: child,
          ),
        ),
      ),
    ),
  );
}
