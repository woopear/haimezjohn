import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/projet/state/projet_state.dart';

final projetChange = ChangeNotifierProvider<ProjetState>(
  (ref) => ProjetState(),
);
