import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models_shared/info_perso/state/info_perso_state.dart';

final infoPersoChange = ChangeNotifierProvider<InfoPersoState>(
  (ref) => InfoPersoState(),
);

final infoPersoOneStream = StreamProvider((ref) {
  return ref.watch(infoPersoChange).streamOneInfoPerso();
});
