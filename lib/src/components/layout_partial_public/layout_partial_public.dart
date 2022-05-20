import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget layoutPartialPublic({
  required Widget child,
  required BuildContext context,
}) =>
    Container(
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(vertical: 70.0)
          : const EdgeInsets.symmetric(vertical: 30.0),
      child: SizedBox(
        width: Responsive.isDesktop(context) ? 1050 : double.infinity,
        child: child,
      ),
    );
