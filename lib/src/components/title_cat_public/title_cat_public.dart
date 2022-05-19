import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget titleCatPublic({
  required String title,
  String? subTitle,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  bool oneOnOne = false,
  required BuildContext context,
}) {
  double sizeTitle = Responsive.isDesktop(context) ? 86 : 40;
  double sizeSubTitle = Responsive.isDesktop(context) ? 40 : 24;

  return Container(
    margin: margin,
    padding: padding,
    width: double.infinity,
    child:
        Text(
      title,
      textAlign: TextAlign.justify,
      style: const TextStyle().copyWith(
        fontWeight: FontWeight.bold,
        fontSize: sizeTitle,
        color: Theme.of(context).brightness == Brightness.dark
            ? ColorCustom().greyTextDark
            : ColorCustom().greyText,
      ),
    ),
  );
}
