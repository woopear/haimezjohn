import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class ProfilState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute profils
  Stream<List<ProfilSchema>> streamProfils() {
    return _firestore.streamCol<ProfilSchema>(
      path: FirestorePath.profils(),
      builder: (data, documentId) => ProfilSchema.fromMap(data, documentId),
    );
  }

  /// read profil directus
  Future<ProfilSchema> getProfil() async {
    final res = await http.get(
      Uri.parse('https://2v5q6w6a.directus.app/items/profil'),
    );

    final resJson = jsonDecode(res.body)['data'] as Map<String, dynamic>;
    final profil = ProfilSchema.fromMap(resJson, resJson['id'].toString());

    return profil;
  }

  /// add
  Future<void> addProfil(ProfilSchema newProfil) async {
    await _firestore.add(
      path: FirestorePath.profils(),
      data: newProfil.toMap(),
    );
  }

  /// update
  Future<void> updateProfil(String idProfil, ProfilSchema newProfil) async {
    await _firestore.update(
      path: FirestorePath.profil(idProfil),
      data: newProfil.toMap(),
    );
  }

  /// delete
  Future<void> deleteProfil(String idProfil) async {
    await _firestore.delete(
      path: FirestorePath.profil(idProfil),
    );
  }
}
