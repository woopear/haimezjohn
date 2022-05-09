import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

Widget linkPublicWidget(
  LinkSchema link, {
  required void Function()? onPressed,
  required bool finishTab,
}) {
  Widget? icon;

  switch (link.name) {
    case 'Linkedin':
      icon = FaIcon(
        FontAwesomeIcons.linkedin,
        size: 80,
        color: ColorCustom().blue,
      );
      break;
    case 'Github':
      icon = const FaIcon(
        FontAwesomeIcons.github,
        size: 80,
        color: Colors.white,
      );
      break;
    case 'Discord':
      icon = FaIcon(
        FontAwesomeIcons.discord,
        size: 80,
        color: ColorCustom().blueLight,
      );
      break;
    default:
  }

  return Container(
    margin: finishTab
        ? const EdgeInsets.only(right: 0.0)
        : const EdgeInsets.only(right: 70.0),
    child: InkWell(
      splashColor: ColorCustom().greenLight, // splash color
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              link.name,
              style: const TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
