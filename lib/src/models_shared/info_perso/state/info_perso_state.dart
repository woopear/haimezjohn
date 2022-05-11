import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models_shared/info_perso/schema/info_perso_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class InfoPersoState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream one
  Stream<InfoPersoSchema?> streamOneInfoPerso() {
    final response = _firestore.streamCol(
      path: FirestorePath.infoPersos(),
      builder: (data, documentId) => InfoPersoSchema.fromMap(data, documentId),
    );

    return response.map((event) {
      if (event.isNotEmpty) {
        return event[0];
      }
      return null;
    });
  }

  /// add
  Future<void> addInfoPerso(
    InfoPersoSchema newInfoPerso,
  ) async {
    await _firestore.add(
      path: FirestorePath.infoPersos(),
      data: newInfoPerso.toMap(),
    );
  }

  /// update
  Future<void> updateInfoPerso(
    String idInfoPerso,
    InfoPersoSchema newInfoPerso,
  ) async {
    await _firestore.update(
      path: FirestorePath.infoPerso(idInfoPerso),
      data: newInfoPerso.toMap(),
    );
  }

  /// delete
  Future<void> deleteInfoPerso(
    String idInfoPerso,
  ) async {
    await _firestore.delete(
      path: FirestorePath.infoPerso(idInfoPerso),
    );
  }
}
