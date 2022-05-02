import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models_shared/footer/state/footer_state.dart';

final footerChange = ChangeNotifierProvider<FooterState>(
  (ref) => FooterState(),
);

final footerOneStream = StreamProvider((ref) {
  return ref.watch(footerChange).streamOneFooter();
});
