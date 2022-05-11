import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class LinkState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream all
  Stream<List<LinkSchema?>> streamAllLink() {
    return _firestore.streamCol(
      path: FirestorePath.links(),
      builder: (data, documentId) => LinkSchema.fromMap(data, documentId),
    );
  }

  /// add
  Future<void> addLink(LinkSchema newLink,) async {
    await _firestore.add(
      path: FirestorePath.links(),
      data: newLink.toMap(),
    );
  }

  /// update
  Future<void> updateLink(String idLink ,LinkSchema newLink,) async {
    await _firestore.update(
      path: FirestorePath.link(idLink),
      data: newLink.toMap(),
    );
  }

  /// delete
  Future<void> deleteLink(String idLink,) async {
    await _firestore.delete(
      path: FirestorePath.link(idLink),
    );
  }
}
