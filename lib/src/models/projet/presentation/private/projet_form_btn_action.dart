import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/btn_close/btn_close.dart';
import 'package:haimezjohn/src/components/btn_icon_save/btn_icon_save.dart';

Widget btnActionFormProjet({
  required void Function()? onPressedSave,
  required void Function()? onPressedClose,
}) =>
    Container(
      child: Row(
        children: [
          /// btn save
          btnIconSave(
              onPressed: onPressedSave,
              message: 'Enregistrer les modifications'),

          /// btn close
          btnClose(
              onPressed: onPressedClose,
              message: 'Fermer le volet de modification'),
        ],
      ),
    );