import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

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
        child:  Container(
          color: ColorCustom().greyPerso,
            child: child,
        ),
      ),
    ),
  );
}
