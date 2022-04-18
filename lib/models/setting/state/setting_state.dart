import 'package:flutter/material.dart';
import 'package:haimezjohn/models/setting/schema/setting_schema.dart';
import 'package:haimezjohn/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class SettingState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute setting
  Stream<List<SettingSchema>> streamSettings() {
    return _firestore.streamCol(
      path: FirestorePath.settings(),
      builder: (data, documentId) => SettingSchema.fromMap(data, documentId),
    );
  }

  /// recupere les settings
  Future<List<SettingSchema>> futureSettings() async {
    return await _firestore.getCol(
      path: FirestorePath.settings(),
      builder: (data, documentId) => SettingSchema.fromMap(data, documentId),
    );
  }

  /// update
  Future<void> updateSetting(String idSetting, SettingSchema newSetting) async {
    await _firestore.update(
      path: FirestorePath.setting(idSetting),
      data: newSetting.toMap(),
    );
  }
}
