import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class Upload {
  final _firebaseStorage = FirebaseStorage.instance;

  dynamic file;
  String? extention;
  String? url;
  String? urlPdf;
  FilePickerResult? pickerImage;
  FilePickerResult? pickerPdf;

  Upload({
    this.file,
    this.extention,
    this.url,
    this.urlPdf,
    this.pickerImage,
    this.pickerPdf,
  });

  /// reset toutes les variables
  void resetAllVar() {
    file = null;
    extention = null;
    url = null;
    urlPdf = null;
    pickerImage = null;
    pickerPdf = null;
  }

  /// selectionne une image
  Future<void> selectedImage() async {
    if (kIsWeb) {
      pickerImage = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
    } else {
      pickerImage = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
    }
  }

  /// selectionne pdf
  Future<void> selectedPdf() async {
    if (kIsWeb) {
      pickerPdf = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
    } else {
      pickerPdf = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
    }
  }

  /// upload bdd
  Future<void> uploadFile({
    required bool pdf,
    String? url,
    modelUpload,
  }) async {
    /// si web sinon le reste
    if (kIsWeb) {
      if (pdf) {
        /// on recupere le path
        file = pickerPdf!.files.first.bytes;
        extention = pickerPdf!.files.first.extension;

        urlPdf = url;
      } else {
        /// on recupere le path
        file = pickerImage!.files.first.bytes;
        extention = pickerImage!.files.first.extension;

        url = url;
      }
    } else {
      if (pdf) {
        file = File(pickerPdf!.files.single.path!);
        urlPdf = url;
      } else {
        file = File(pickerImage!.files.single.path!);
        url = url;
      }
    }
  }

  /// delete image/file
  Future<void> deleteImage(String pathImage) async {
    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child(pathImage);

    /// on delete
    await ref.delete();
  }
}
