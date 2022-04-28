import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/btn_update_entitie/btn_update_entite.dart';
import 'package:haimezjohn/src/components/index.dart';

Widget btnActionListProjet({
  required void Function()? onPressedUpdate,
  required void Function()? onPressedDelete,
}) =>
    Container(
      child: Row(
        children: [
          /// update entité
          btnUpdateEntite(
            onPressed: onPressedUpdate,
            message: 'Modifier le projet',
            iconSize: 20.0,
          ),

          /// delete entitié
          btnDeleteOne(
            onPressed: onPressedDelete,
            message: 'Supprimer le projet',
            iconSize: 20.0,
          ),
        ],
      ),
    );
