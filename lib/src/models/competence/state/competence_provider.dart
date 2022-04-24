import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/competence/state/competence_state.dart';

/// state class CompetenceState
final competenceChange =
    ChangeNotifierProvider<CompetenceState>((ref) => CompetenceState());

/// stream de toute les competences
final competencesStream = StreamProvider((ref) {
  return ref.watch(competenceChange).streamCompetences();
});
