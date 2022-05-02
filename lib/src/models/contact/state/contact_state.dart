import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/contact/schema/contact_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class ContactState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream le contact
  Stream<ContactSchema?> streamOneContact() {
    final response = _firestore.streamCol(
      path: FirestorePath.contacts(),
      builder: (data, documentId) => ContactSchema.fromMap(data, documentId),
    );

    return response.map((event) {
      if (event.isNotEmpty) {
        return event[0];
      }
      return null;
    });
  }

  /// add
  Future<void> addContact(
    ContactSchema newContact,
  ) async {
    await _firestore.add(
      path: FirestorePath.contacts(),
      data: newContact.toMap(),
    );
  }

  /// update
  Future<void> updateContact(
    String idContact,
    ContactSchema newContact,
  ) async {
    await _firestore.update(
      path: FirestorePath.contact(idContact),
      data: newContact.toMap(),
    );
  }

  /// delete
  Future<void> deleteContact(
    String idContact,
  ) async {
    await _firestore.delete(
      path: FirestorePath.contact(
        idContact,
      ),
    );
  }
}
