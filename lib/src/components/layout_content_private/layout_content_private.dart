import 'package:flutter/material.dart';

Widget layoutContentPrivate({
  required List<Widget> children,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 70.0,
      horizontal: 30.0,
    ),
    child: Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    ),
  );
}
