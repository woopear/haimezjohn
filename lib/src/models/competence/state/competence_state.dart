import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/competence/schema/competence_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class CompetenceState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute toutes les competences
  Stream<List<CompetenceSchema>> streamCompetences() {
    return _firestore.streamCol(
      path: FirestorePath.competences(),
      builder: (data, documentId) => CompetenceSchema.fromMap(data, documentId),
    );
  }

  /// add
  Future<void> addCompetence(CompetenceSchema newCompetence) async {
    await _firestore.add(
      path: FirestorePath.competences(),
      data: newCompetence.toMap(),
    );
  }

  /// update
  Future<void> updateCompetence(
      String idCompetence, CompetenceSchema newCompetence) async {
    await _firestore.update(
      path: FirestorePath.competence(idCompetence),
      data: newCompetence.toMap(),
    );
  }

  /// delete
  Future<void> deleteCompetence(String idCompetence) async {
    /// todo si delete delete toutes les technos relier

    /// delete competence
    await _firestore.delete(
      path: FirestorePath.competence(idCompetence),
    );
  }
}
