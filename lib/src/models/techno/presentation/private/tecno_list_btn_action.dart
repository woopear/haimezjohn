import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/btn_update_entitie/btn_update_entite.dart';
import 'package:haimezjohn/src/components/index.dart';

Widget btnActionListTechno({
  required void Function()? onPressedUpdate,
  required void Function()? onPressedDelete,
}) =>
    Container(
      child: Row(
        children: [
          /// update entité
          btnUpdateEntite(
            onPressed: onPressedUpdate,
            message: 'Modifier la techno',
            iconSize: 20.0,
          ),

          /// delete entitié
          btnDeleteOne(
            onPressed: onPressedDelete,
            message: 'Supprimer la techno',
            iconSize: 20.0,
          ),
        ],
      ),
    );
