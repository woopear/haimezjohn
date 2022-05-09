import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

Widget linkPublicWidget(
  LinkSchema link, {
  required void Function()? onPressed,
  required bool finishTab,
  required BuildContext context,
}) {
  Widget? icon;
  double sizeIcon = Responsive.isDesktop(context) ? 80 : 50;

  switch (link.name) {
    case 'Linkedin':
      icon = FaIcon(
        FontAwesomeIcons.linkedin,
        size: sizeIcon,
        color: ColorCustom().blue,
      );
      break;
    case 'Github':
      icon = FaIcon(
        FontAwesomeIcons.github,
        size: sizeIcon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      );
      break;
    case 'Discord':
      icon = FaIcon(
        FontAwesomeIcons.discord,
        size: sizeIcon,
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
      onTap: () {
        launchUrl(Uri.parse(link.link));
      },
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
