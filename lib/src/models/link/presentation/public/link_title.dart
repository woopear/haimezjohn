import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

Widget linkTitle({required BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(top: 90.0),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Moi, moi, moi',
          style: const TextStyle().copyWith(
            fontSize: 36,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorCustom().greyTextDark
                : ColorCustom().greyText,
          ),
        ),
        Text(
          'et encore MOI',
          style: const TextStyle().copyWith(
            fontSize: 56,
            color: ColorCustom().greenLight,
          ),
        ),
      ],
    ),
  );
}
