import 'package:flutter/material.dart';

/// style du text du head du tableau
TextStyle arrayTextStyleHead = const TextStyle(
  fontWeight: FontWeight.bold,
);

/// style du text du corps du tableau
TextStyle arrayTextStyleContent = const TextStyle();

/// padding du tableau
double paddingArray = 10.0;

/// color des lignes du tableau
TableBorder? borderOfArray = TableBorder.all(color: Colors.grey);
TableBorder? borderOfArrayDark = TableBorder.all(color: Colors.grey);
TableBorder? borderOfArrayClaire = TableBorder.all(color: Colors.grey);

/// alignement du text du tableau
TextAlign? arrayTextAlignHead;
TextAlign? arrayTextAlignContent;
