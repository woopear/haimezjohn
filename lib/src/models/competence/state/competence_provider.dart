import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/competence/schema/competence_schema.dart';
import 'package:haimezjohn/src/models/competence/state/competence_state.dart';

/// state class CompetenceState
final competenceChange =
    ChangeNotifierProvider<CompetenceState>((ref) => CompetenceState());

/// stream de toute les competences
final competencesStream = StreamProvider((ref) {
  return ref.watch(competenceChange).streamCompetences();
});

/// provider de une competences
final competencesProvider = Provider((ref) {
  CompetenceSchema? c;
  ref.watch(competencesStream).whenData((value) {
    c = value[0];
  });

  return c;
});

/// provider de l'id competence
final idCompetenceProvider = Provider((ref) {
  return ref.watch(competenceChange).idCompetence;
});
