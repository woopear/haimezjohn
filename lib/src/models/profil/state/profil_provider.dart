import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/models/profil/state/profil_state.dart';

/// state de la class ProfilState
final profilChange = ChangeNotifierProvider<ProfilState>(
  (ref) => ProfilState(),
);

final profilFuture = FutureProvider((ref) {
  return ref.watch(profilChange).getProfil();
});

/// stream de tous les profils
final profilsStream = StreamProvider((ref) {
  return ref.watch(profilChange).streamProfils();
});

/// provider de profil
final profilProvider = Provider((ref) {
  ProfilSchema? profil;
  ref.watch(profilsStream).whenData((value) {
    profil = value[0];
  });
  return profil;
});
