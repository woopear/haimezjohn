import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/condition_gene/schema/condition_gene_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_state.dart';

final conditionGeneChange = ChangeNotifierProvider<ConditionGeneState>(
  (ref) => ConditionGeneState(),
);

final conditionGeneAllStream = StreamProvider((ref) {
  return ref.watch(conditionGeneChange).streamAllConditionGene();
});

final conditionGenePublicStream = StreamProvider((ref) {
  Stream<ConditionGeneSchema?>? c;
  ref.watch(conditionGeneAllStream).whenData((value) {
    ref.watch(conditionGeneChange).streamOneConditionGene(value[0]!.id!);
    c = ref.watch(conditionGeneChange).conditionSelected!;
  });
  return c!.cast();
});

final conditionGeneOneStream = StreamProvider((ref) {
  return ref.watch(conditionGeneChange).conditionSelected!;
});

/// provider de la condition selectionné pour modification
final projetSelectedUpdateProvider = Provider((ref) {
  ConditionGeneSchema? condition;
  ref.watch(conditionGeneOneStream).whenData((value) {
    condition = value;
  });
  return condition;
});

/// provider pour l'id de la condition selectionné
final idConditionGeneProvider = Provider((ref) {
  return ref.watch(conditionGeneChange).idConditionSelected;
});
