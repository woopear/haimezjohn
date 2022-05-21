import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/link/state/link_state.dart';

final linkChange = ChangeNotifierProvider<LinkState>(
  (ref) => LinkState(),
);

final linkAllFuture = FutureProvider((ref) {
  return ref.watch(linkChange).getAllLink();
});

final linkAllStream = StreamProvider((ref) {
  return ref.watch(linkChange).streamAllLink();
});
