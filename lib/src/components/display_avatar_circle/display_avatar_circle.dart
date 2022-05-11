import 'package:flutter/material.dart';

Widget displayAvatartCircle({
  String? image,
  double size = 150,
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 10.0, bottom: 10.0),
  required BuildContext context,
}) => Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey
            : Colors.black12,
        shape: BoxShape.circle,
      ),
      child: image != null && image != ''
          ? CircleAvatar(
              radius: size / 2,
              backgroundImage: NetworkImage(
                image,
              ),
            )
          : Icon(Icons.person, size: size),
    );
