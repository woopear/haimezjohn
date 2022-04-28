import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/projet/schema/projet_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class ProjetState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  late Stream<ProjetSchema?>? _projetSelectedUpdate;
  Stream<ProjetSchema?>? get projetSelectedUpdate => _projetSelectedUpdate;

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

  /// reset projet selectionné pour modification
  void resetProjetSelectedUpdate() {
    _projetSelectedUpdate = null;
    notifyListeners();
  }
}
