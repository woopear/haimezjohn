import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class TechnoState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute toute les technos
  Stream<List<TechnoSchema>> streamTechnos(String idCompetence) {
    return _firestore.streamCol(
      path: FirestorePath.technos(idCompetence),
      builder: (data, documentId) => TechnoSchema.fromMap(data, documentId),
    );
  }

  /// add
  Future<void> addTechno(String idCompetence, TechnoSchema newTechno) async {
    await _firestore.add(
      path: FirestorePath.technos(idCompetence),
      data: newTechno.toMap(),
    );
  }

  /// update
  Future<void> updateTechno(
      String idCompetence, String idTechno, TechnoSchema newTechno) async {
    await _firestore.update(
      path: FirestorePath.techno(idCompetence, idTechno),
      data: newTechno.toMap(),
    );
  }

  /// delete
  Future<void> deleteTechno(String idCompetence, String idTechno) async {
    await _firestore.delete(path: FirestorePath.techno(idCompetence, idTechno));
  }

  /// delete all
}
