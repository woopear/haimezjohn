import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/profil/state/profil_state.dart';

/// state de la class ProfilState
final profilChange = ChangeNotifierProvider<ProfilState>(
  (ref) => ProfilState(),
);

/// stream de tous les profils
final profilsStream = StreamProvider((ref) {
  return ref.watch(profilChange).streamProfils();
});
