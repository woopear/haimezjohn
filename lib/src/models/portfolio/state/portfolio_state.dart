import 'package:flutter/material.dart';
import 'package:haimezjohn/src/models/portfolio/schema/portfolio_schema.dart';
import 'package:haimezjohn/src/utils/fire/firestorepath.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';

class PortfolioState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute tous les portfolios
  Stream<List<PortfolioSchema>> streamPortfolios() {
    return _firestore.streamCol(
      path: FirestorePath.portfolios(),
      builder: (data, documentId) => PortfolioSchema.fromMap(data, documentId),
    );
  }

  /// add
  Future<void> addPortfolio(PortfolioSchema newPortfolio) async {
    await _firestore.add(
      path: FirestorePath.portfolios(),
      data: newPortfolio.toMap(),
    );
  }

  /// update
  Future<void> updatePortfolio(
      String idPortfolio, PortfolioSchema newPortfolio) async {
    await _firestore.update(
      path: FirestorePath.portfolio(idPortfolio),
      data: newPortfolio.toMap(),
    );
  }

  /// delete
  Future<void> deletePortfolio(String idPortfolio) async {
    /// todo delete tout les projets
    await _firestore.delete(path: FirestorePath.portfolio(idPortfolio));
  }
}
