import 'package:flutter/material.dart';

Widget layoutPagePublic({
  required BuildContext context,
  required Widget child,
  bool seeAppBar = false,
}) {
  return SafeArea(
    child: Scaffold(
      appBar: seeAppBar ? AppBar(
      ) : null,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 30.0),
            margin: const EdgeInsets.only(bottom: 0.0),
            child: child,
          ),
        ),
      ),
    ),
  );
}
