import 'package:flutter/material.dart';
import 'package:haimezjohn/src/components/array/array_config.dart';
import 'package:haimezjohn/src/components/array/array_row.dart';

Widget array<T>({
  required List<String> cellsHead,
  required List<TableRow> cells,
  required BuildContext context,
}) =>
    Table(
      border: Theme.of(context).brightness == Brightness.dark
          ? borderOfArrayDark
          : borderOfArrayClaire,
      children: [
        /// head
        arrayRow(
          cells: cellsHead,
          isHead: true,
        ),

        /// corps
        ...cells
      ],
    );
