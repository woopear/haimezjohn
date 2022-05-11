import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

Widget contactTitle({required BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(top: 90.0),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Pas envie d'écrire ?",
          style: const TextStyle().copyWith(
            fontSize: Responsive.isDesktop(context) ? 36 : 26,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorCustom().greyTextDark
                : ColorCustom().greyText,
          ),
        ),
        Text(
          "OK ! Voici d'autres infos",
          style: const TextStyle().copyWith(
            fontSize: Responsive.isDesktop(context) ? 56 : 36,
            color: ColorCustom().greenLight,
          ),
        ),
      ],
    ),
  );
}
