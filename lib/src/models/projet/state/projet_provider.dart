import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';
import 'package:haimezjohn/src/models/projet/state/projet_state.dart';

final projetChange = ChangeNotifierProvider<ProjetState>(
  (ref) => ProjetState(),
);

/// stream de tous les projet du portfolio
final projetsOfProfilStream = StreamProvider((ref) {
  Stream<Object?>? refStream;
  ref.watch(portfoliosStream).whenData((value) {
    refStream =
        ref.watch(projetChange).streamAllProjetWithIdPortfolio(value[0].id!);
  });
  return refStream!.cast();
});
