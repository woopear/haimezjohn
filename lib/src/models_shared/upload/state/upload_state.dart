import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';

class UploadFile extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  /// upload image techno
  Future<String> uploadImageTechno(
    data, {
    String extension = '',
    required String idTechno,
  }) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage
        .ref()
        .child('${Globals.adresseStorageImageTechno}$idTechno');

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }

    /// on enregistre sur firebase mode mobile
    file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  /// upload pdf pour competence
  Future<String> uploadPdfCompetence(data, {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref =
        _firebaseStorage.ref().child(Globals.adresseStoragePdfCompetence);

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file = ref.putData(
          data, SettableMetadata(contentType: 'application/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }

    /// on enregistre sur firebase mode mobile
    file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  /// upload image pour competence
  Future<String> uploadImageCompetence(data, {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref =
        _firebaseStorage.ref().child(Globals.adresseStorageImageCompetence);

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }

    /// on enregistre sur firebase mode mobile
    file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  /// upload image pour profil
  Future<String> uploadImageProfil(data, {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child(Globals.adresseStorageProfil);

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }

    /// on enregistre sur firebase mode mobile
    file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  /// upload image pour utilisateur
  Future<String> uploadAvatar(data, String uid, {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('avatars/user-$uid');

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }

    /// on enregistre sur firebase mode mobile
    file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne pour enregistrer
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  /// delete image presentation
  Future<void> deleteImage(String pathImage) async {
    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child(pathImage);

    /// on delete
    await ref.delete();
  }
}
