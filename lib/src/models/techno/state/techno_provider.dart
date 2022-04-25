import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_state.dart';

/// state de la class techno state
final technoChange =
    ChangeNotifierProvider<TechnoState>((ref) => TechnoState());

/// toute les techno avec l'id competence en params
final technosStreamIdCompetence =
    StreamProvider.family((ref, String idCompetence) {
  return ref.watch(technoChange).streamTechnos(idCompetence);
});

/// toute les techno sans l'id competence en params
final technosStream = StreamProvider<List<TechnoSchema>>((ref) {
  Stream<Object?>? refStream;
  ref.watch(competencesStream).whenData((value) {
    refStream = ref.watch(technoChange).streamTechnos(value[0].id!);
  });
  return refStream!.cast();
});

/// stream de la techno selectionné pour update
final technoSelectedUpdateStream = StreamProvider((ref) {
  return ref.watch(technoChange).technoSelected!;
});

/// la techno selectionné pour update
final technoSelectedUpdateProvider = Provider((ref) {
  TechnoSchema? techno;
  ref.watch(technoSelectedUpdateStream).whenData((value) {
    techno = value;
  });
  return techno;
});
