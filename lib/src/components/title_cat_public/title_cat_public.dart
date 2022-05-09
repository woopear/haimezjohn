import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget titleCatPublic({
  required String title,
  required String subTitle,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  required BuildContext context,
}) =>
    Container(
      margin: margin,
      padding: padding,
      width: double.infinity,
      child: Responsive.isDesktop(context)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                /// text base
                Text(
                  title,
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 86,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorCustom().greyTextDark
                        : ColorCustom().greyText,
                  ),
                ),

                /// super text
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    subTitle,
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// text base
                Text(
                  title,
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 86,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? ColorCustom().greyTextDark
                        : ColorCustom().greyText,
                  ),
                ),

                /// super text
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    subTitle,
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
    );
