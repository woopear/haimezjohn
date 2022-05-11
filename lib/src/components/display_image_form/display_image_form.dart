import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';

/// si il y a le picker de remplie on affiche le picker
/// sinon si l'entité à une image on affiche l'image
/// sinon on affiche l'image par default
Widget displayImage({
  FilePickerResult? picker,
  required String urlE,
  double? height = 100.0,
  bool? circle = false,
  double? width = double.infinity,
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 20.0),
  EdgeInsetsGeometry? padding,
}) =>
    Container(
      margin: margin,
      padding: padding,
      child: picker != null
          ? Image.memory(
              picker.files.first.bytes!,
              height: height,
              width: width,
            )
          : urlE != ''
              ? circle!
                  ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: height! / 2,
                      backgroundImage: NetworkImage(
                        urlE,
                      ),
                    )
                  : Image.network(
                      urlE,
                      height: height,
                      width: width,
                    )
              : Image.network(
                  Globals.urlAucuneImage,
                  height: height,
                  width: width,
                ),
    );
