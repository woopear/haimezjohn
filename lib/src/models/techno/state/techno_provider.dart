import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_state.dart';

final technoChange =
    ChangeNotifierProvider<TechnoState>((ref) => TechnoState());

final technosStream = StreamProvider.family((ref, String idCompetence) {
  return ref.watch(technoChange).streamTechnos(idCompetence);
});

final t = StreamProvider<List<TechnoSchema>>((ref) {
  String? idCompetence;
  Stream<Object?>? refStream;
  ref.watch(competencesStream).whenData((value) {
    idCompetence = value[0].id;
    refStream = ref.watch(technoChange).streamTechnos(idCompetence!);
  });
  return refStream!.cast();
});
