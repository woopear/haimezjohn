import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class LinkState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream all
  Stream<List<LinkSchema?>> streamAllLink() {
    return _firestore.streamCol(
      path: FirestorePath.links(),
      builder: (data, documentId) => LinkSchema.fromMap(data, documentId),
    );
  }

  /// get all link directus
  Future<List<LinkSchema?>> getAllLink() async {
    final res = await http.get(
      Uri.parse('https://8oj0p722.directus.app/items/link'),
    );

    final resJson = jsonDecode(res.body)['data'] as List;
    
    List<LinkSchema?> links = [];
    for (var element in resJson) {
      final link = LinkSchema.fromMap(element, element['id'].toString());
      links.add(link);
    }

    return links;
  }

  /// add
  Future<void> addLink(
    LinkSchema newLink,
  ) async {
    await _firestore.add(
      path: FirestorePath.links(),
      data: newLink.toMap(),
    );
  }

  /// update
  Future<void> updateLink(
    String idLink,
    LinkSchema newLink,
  ) async {
    await _firestore.update(
      path: FirestorePath.link(idLink),
      data: newLink.toMap(),
    );
  }

  /// delete
  Future<void> deleteLink(
    String idLink,
  ) async {
    await _firestore.delete(
      path: FirestorePath.link(idLink),
    );
  }
}
