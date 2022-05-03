import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/condition_gene/schema/condition_gene_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class ConditionGeneState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  late Stream<ConditionGeneSchema?> _conditionSelected;
  Stream<ConditionGeneSchema?> get conditionSelected => _conditionSelected;

  String? _idConditionSelected;
  String? get idConditionSelected => _idConditionSelected;

  /// recupere id condition gene selectionnée
  void setidConditionSelected(String idConditionGene) {
    _idConditionSelected = idConditionSelected;
  }

  /// stream all
  Stream<List<ConditionGeneSchema?>> streamAllConditionGene() {
    return _firestore.streamCol(
      path: FirestorePath.conditionGenes(),
      builder: (data, documentId) =>
          ConditionGeneSchema.fromMap(data, documentId),
    );
  }

  /// stream one
  Stream<void>? streamOneConditionGene(String idConditionGene) {
    _conditionSelected = _firestore.streamDoc(
      path: FirestorePath.conditionGene(idConditionGene),
      builder: (data, documentId) =>
          ConditionGeneSchema.fromMap(data, documentId),
    );

    return null;
  }

  /// add
  Future<void> addConditionGene(
    ConditionGeneSchema newConditionGene,
  ) async {
    await _firestore.add(
      path: FirestorePath.conditionGenes(),
      data: newConditionGene.toMap(),
    );
  }

  /// update
  Future<void> updateConditionGene(
    String idConditionGene,
    ConditionGeneSchema newConditionGene,
  ) async {
    await _firestore.update(
      path: FirestorePath.conditionGene(idConditionGene),
      data: newConditionGene.toMap(),
    );
  }

  /// delete
  Future<void> deleteConditionGene(
    String idConditionGene,
  ) async {
    /// todo delete tous les article si delete condition

    /// delete
    await _firestore.delete(
      path: FirestorePath.conditionGene(idConditionGene),
    );
  }
}
