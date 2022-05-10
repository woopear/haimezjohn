import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';
import 'package:haimezjohn/src/models/projet/schema/projet_schema.dart';
import 'package:haimezjohn/src/models/projet/state/projet_state.dart';

final projetChange = ChangeNotifierProvider<ProjetState>(
  (ref) => ProjetState(),
);

/// stream de tous les projet du portfolio
final projetsOfProfilStream = StreamProvider<List<ProjetSchema>>((ref) {
  Stream<List<ProjetSchema>?>? refStream;
  ref.watch(portfoliosStream).whenData((value) {
    refStream =
        ref.watch(projetChange).streamAllProjetWithIdPortfolio(value[0].id!);
  });
  return refStream!.cast();
});

/// stream projet selectionné
final projetSelectedUpdateStream = StreamProvider((ref) {
  return ref.watch(projetChange).projetSelectedUpdate!;
});

/// provider du projet selectionné pour modification
final projetSelectedUpdateProvider = Provider((ref) {
  ProjetSchema? projet;
  ref.watch(projetSelectedUpdateStream).whenData((value) {
    projet = value;
  });
  return projet;
});
