import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:haimezjohn/src/models/projet/schema/projet_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class ProjetState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  late Stream<ProjetSchema?>? _projetSelectedUpdate;
  Stream<ProjetSchema?>? get projetSelectedUpdate => _projetSelectedUpdate;

  String? _idPortfolioCurrent;
  String? get idPortfolioCurrent => _idPortfolioCurrent;

  /// stream all
  Stream<List<ProjetSchema>> streamAllProjetWithIdPortfolio(
    String idPortfolio,
  ) {
    return _firestore.streamCol(
      path: FirestorePath.projets(idPortfolio),
      builder: (data, documentId) => ProjetSchema.fromMap(data, documentId),
    );
  }

  /// stream one
  Stream<ProjetSchema?>? streamProjetSelected(
      String idPortfolio, String idProjet) {
    _projetSelectedUpdate = _firestore.streamDoc<ProjetSchema>(
      path: FirestorePath.projet(idPortfolio, idProjet),
      builder: (data, documentId) => ProjetSchema.fromMap(data, documentId),
    );
    notifyListeners();
    return null;
  }

  /// get tous les projets depuis directus
  Future<List<ProjetSchema>> getAllProjet() async {
    final res = await http.get(
      Uri.parse('https://8oj0p722.directus.app/items/projet'),
    );

    final resJson = jsonDecode(res.body)['data'] as List;
    List<ProjetSchema> projets = [];
    for (var element in resJson) {
      final projet = ProjetSchema.fromMap(element, element['id'].toString());
      projets.add(projet);
    }

    return projets;
  }

  /// add
  Future<void> addProjet(
    String idPortfolio,
    ProjetSchema newProjet,
  ) async {
    await _firestore.add(
      path: FirestorePath.projets(idPortfolio),
      data: newProjet.toMap(),
    );
  }

  /// update
  Future<void> updateProjet(
    String idPortfolio,
    String idProjet,
    ProjetSchema newProjet,
  ) async {
    await _firestore.update(
      path: FirestorePath.projet(idPortfolio, idProjet),
      data: newProjet.toMap(),
    );
  }

  /// delete
  Future<void> deleteProjet(
    String idPortfolio,
    String idProjet,
  ) async {
    await _firestore.delete(
      path: FirestorePath.projet(
        idPortfolio,
        idProjet,
      ),
    );
  }

  /// delete all
  Future<void> deleteAllProjet(
    String idPortfolio,
  ) async {
    /// instance firestore pour batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref collection path
    CollectionReference ref = FirebaseFirestore.instance.collection(
      FirestorePath.projets(idPortfolio),
    );

    /// boucle pour delete
    return ref.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }

  /// upload image projet
  Future<String> uploadImageProjet(data, String idProjet,
      {String extension = ''}) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('projets/proj-$idProjet');

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

  /// reset projet selectionné pour modification
  void resetProjetSelectedUpdate() {
    _projetSelectedUpdate = null;
    notifyListeners();
  }

  /// affecte id du portfolio en cours
  void getIdPortfolio(String idPortfolio) {
    _idPortfolioCurrent = idPortfolio;
    notifyListeners();
  }
}
