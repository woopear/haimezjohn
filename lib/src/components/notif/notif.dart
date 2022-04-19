import 'package:flutter/material.dart';

class Notif {
  String? text;
  bool? error;

  Notif({
    Key? key,
    required this.text,
    required this.error,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notification(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text!,
          style: TextStyle(
            color: error! ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}