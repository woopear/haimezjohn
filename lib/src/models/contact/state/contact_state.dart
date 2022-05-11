import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/contact/schema/contact_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:http/http.dart' as http;

class ContactState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final String _serviceId = 'service_a30i758';
  final String _templateId = 'template_d9ux35h';
  final String _userId = 'vTJ7Vnhs75H5wSA5u';

  /// envoie email de contact
  Future<void> sendEmailContactClient(
      String subject,
      TextEditingController userName,
      TextEditingController userEmail,
      TextEditingController userMessage) async {
    await http.post(
      _url,
      headers: {'origin': 'http://localhost','Content-Type': 'application/json'},
      body: json.encode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': {
          'user_subject': subject,
          'user_name': userName.text.trim(),
          'user_email': userEmail.text.trim(),
          'user_message': userMessage.text.trim(),
        }
      }),
    );
  }

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
