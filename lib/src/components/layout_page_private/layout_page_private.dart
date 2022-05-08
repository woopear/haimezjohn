import 'package:flutter/material.dart';

Widget layoutPagePrivate({required Widget child}) {
  return SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: child,
        ),
      ),
    ),
  );
}
