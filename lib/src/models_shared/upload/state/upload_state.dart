import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UploadFile extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  /// upload image pour profil utilisateur
  Future<String> uploadImageProfil(data, {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('profils/image-profil');

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne pour enregistrer dans le user
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

  /// upload image pour profil utilisateur
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

      /// on recupere l'url et on la retourne pour enregistrer dans le user
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

  /// upload image presentation
  Future<String> uploadImagePresentation(data, {String extension = ''}) async {
        UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('presentation/pres-woopear');

    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file =
          ref.putData(data, SettableMetadata(contentType: 'image/$extension'));

      /// on recupere le fichier
      final snapshot = await file.whenComplete(() {});

      /// on recupere l'url et on la retourne pour enregistrer dans le user
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