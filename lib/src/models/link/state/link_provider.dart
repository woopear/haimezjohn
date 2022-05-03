import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/link/state/link_state.dart';

final linkChange = ChangeNotifierProvider<LinkState>(
  (ref) => LinkState(),
);

final linkAllStream = StreamProvider((ref) {
  return ref.watch(linkChange).streamAllLink();
});
