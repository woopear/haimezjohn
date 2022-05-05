import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/array/array_btn_action_update_delete.dart';
import 'package:haimezjohn/src/components/array/array_config.dart';

TableRow arrayRow({
  required List<String> cells,
  bool isHead = false,
  bool seeAction = false,
  TextStyle? textStyleHead,
  TextStyle? textStyleContent,
  void Function()? onPressedUpdate,
  void Function()? onPressedDelete,
}) =>
    TableRow(
      children: isHead

          /// head du tableau
          ? cells.map((cell) {
              return Padding(
                padding: EdgeInsets.all(paddingArray),
                child: Text(
                  cell,
                  style: textStyleHead ?? arrayTextStyleHead,
                  textAlign: arrayTextAlignHead,
                ),
              );
            }).toList()

          /// content du tableau
          : cells.map(
              (cell) {
                return cell == 'btnaction'

                    /// si il y a le bon text on mets les btn action
                    ? arrayBtnActionUpdateDelete(
                        onPressedUpdate: seeAction ? onPressedUpdate : null,
                        onPressedDelete: seeAction ? onPressedDelete : null,
                      )

                    /// si pas btn action on affiche la donnée
                    : Padding(
                        padding: EdgeInsets.all(paddingArray),
                        child: Text(
                          cell,
                          style: textStyleContent ?? arrayTextStyleContent,
                          textAlign: arrayTextAlignContent,
                        ),
                      );
              },
            ).toList(),
    );
