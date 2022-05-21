import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_state.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class TechnoState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _upload = UploadFile();

  late Stream<TechnoSchema?>? _technoSelected;
  Stream<TechnoSchema?>? get technoSelected => _technoSelected;

  /// ecoute toute les technos
  Stream<List<TechnoSchema>> streamTechnos(String idCompetence) {
    return _firestore.streamCol(
      path: FirestorePath.technos(idCompetence),
      builder: (data, documentId) => TechnoSchema.fromMap(data, documentId),
    );
  }

  /// ecoute une techno
  Stream<TechnoSchema?>? streamTechno(String idCompetence, String idTechno) {
    _technoSelected = _firestore.streamDoc<TechnoSchema>(
      path: FirestorePath.techno(idCompetence, idTechno),
      builder: (data, documentId) => TechnoSchema.fromMap(data, documentId),
    );
    notifyListeners();
    return null;
  }

  /// get techno avec directus
  Future<List<TechnoSchema?>> getAllTechno() async {
    final res = await http.get(
      Uri.parse(
        'https://8oj0p722.directus.app/items/techno?fields=id,title,text,type,images.*',
      ),
    );

    print(res.body);

    final resJson = jsonDecode(res.body)['data'] as List;

    List<TechnoSchema?> technos = [];
    for (var el in resJson) {
      List<ImageTechno> images = [];
      for (var item in el['images']) {
        final image = ImageTechno.fromMap(item, item['id']);
        images.add(image);
      }
      el['images'] = images;
      final techno = TechnoSchema.fromMap(el, el['id'].toString());
      technos.add(techno);
    }

    return technos;
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
    /// delete image de la techno
    await _upload.deleteImage('${Globals.adresseStorageImageTechno}$idTechno');

    ///delete techno
    await _firestore.delete(path: FirestorePath.techno(idCompetence, idTechno));
  }

  /// reset techno selectionné
  void resetTechnoSelected() {
    _technoSelected = null;
    notifyListeners();
  }

  /// todo delete all
}
