import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/contact/state/contact_state.dart';

final contactChange = ChangeNotifierProvider<ContactState>(
  (ref) => ContactState(),
);

final contactStream = StreamProvider((ref) {
  return ref.watch(contactChange).streamOneContact();
});