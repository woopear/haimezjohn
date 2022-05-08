import 'package:flutter/material.dart';

Widget sideMenuItem({
  String? text,
  required IconData icon,
  Color? colorIcon,
  Color? colorText,
  void Function()? onTapText,
  void Function()? onPressedIcon,
  required BuildContext context,
}) {
  colorIcon ??= Theme.of(context).colorScheme.secondary;

  colorText ??= Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black;

  return text != null
      ? ListTile(
          leading: Icon(
            icon,
            color: colorIcon,
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 18.0, color: colorText),
          ),
          hoverColor: Colors.white10,
          onTap: onTapText,
        )
      : IconButton(
          iconSize: 20,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          icon: Icon(
            icon,
            color: colorIcon,
          ),
          onPressed: onPressedIcon,
        );
}
