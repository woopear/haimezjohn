import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/competence/schema/competence_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class CompetenceState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  String? _idCompetence;
  String? get idCompetence => _idCompetence;

  /// recupere l'id de competence
  void getIdCompetence(String idCompetence) {
    _idCompetence = idCompetence;
  }

  /// ecoute toutes les competences
  Stream<List<CompetenceSchema>> streamCompetences() {
    return _firestore.streamCol(
      path: FirestorePath.competences(),
      builder: (data, documentId) => CompetenceSchema.fromMap(data, documentId),
    );
  }

  Future<CompetenceSchema> getCompetence() async {
    final res = await http.get(
      Uri.parse('https://8oj0p722.directus.app/items/competence'),
    );

    final resJson = jsonDecode(res.body)['data'] as Map<String, dynamic>;
    final competence =
        CompetenceSchema.fromMap(resJson, resJson['id'].toString());

    return competence;
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
