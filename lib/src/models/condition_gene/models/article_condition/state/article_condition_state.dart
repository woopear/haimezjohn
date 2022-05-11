import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/schema/article_condition_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class ArticleConditionState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// stream all
  Stream<List<ArticleConditionSchema>> streamAllArticleCondition(
      String idConditionGene) {
    return _firestore.streamCol(
      path: FirestorePath.articleConditionGenes(idConditionGene),
      builder: (data, documentId) =>
          ArticleConditionSchema.fromMap(data, documentId),
    );
  }

  /// add
  Future<void> addArticleCondition(
    String idConditionGene,
    ArticleConditionSchema newArticleConditionGene,
  ) async {
    await _firestore.add(
      path: FirestorePath.articleConditionGenes(idConditionGene),
      data: newArticleConditionGene.toMap(),
    );
  }

  /// update
  Future<void> updateArticleCondition(
    String idConditionGene,
    String idArticleConditionGene,
    ArticleConditionSchema newArticleConditionGene,
  ) async {
    await _firestore.update(
      path: FirestorePath.articleConditionGene(
        idConditionGene,
        idArticleConditionGene,
      ),
      data: newArticleConditionGene.toMap(),
    );
  }

  /// delete
  Future<void> deleteArticleCondition(
    String idConditionGene,
    String idArticleConditionGene,
  ) async {
    await _firestore.delete(
      path: FirestorePath.articleConditionGene(
        idConditionGene,
        idArticleConditionGene,
      ),
    );
  }

  /// supprimer tous les articles d'une condition
  Future<void> deleteAllArticleOfCondition(String idCondition) async {
    /// instance firestore pour batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref collection path
    CollectionReference refArticles = FirebaseFirestore.instance.collection(
      FirestorePath.articleConditionGenes(idCondition),
    );

    /// boucle pour delete les articles
    return refArticles.get().then((querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        /// delete article
        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}
