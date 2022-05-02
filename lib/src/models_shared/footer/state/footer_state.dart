import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models_shared/footer/schema/footer_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class FooterState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream one
  Stream<FooterSchema?> streamOneFooter() {
    final response = _firestore.streamCol(
      path: FirestorePath.footers(),
      builder: (data, documentId) => FooterSchema.fromMap(data, documentId),
    );

    return response.map((event) {
      if (event.isNotEmpty) {
        return event[0];
      }
      return null;
    });
  }

  /// add
  Future<void> addFooter(
    FooterSchema newFooter,
  ) async {
    await _firestore.add(
      path: FirestorePath.footers(),
      data: newFooter.toMap(),
    );
  }

  /// update
  Future<void> updateFooter(
    String idFooter,
    FooterSchema newFooter,
  ) async {
    await _firestore.update(
      path: FirestorePath.footer(idFooter),
      data: newFooter.toMap(),
    );
  }

  /// delete
  Future<void> deleteFooter(
    String idFooter,
  ) async {
    await _firestore.delete(
      path: FirestorePath.footer(idFooter),
    );
  }
}
