import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/array/array.dart';
import 'package:haimezjohn/src/components/array/array_row.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/condition_gene/schema/condition_gene_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_provider.dart';

class ConditionGeneList extends ConsumerStatefulWidget {
  const ConditionGeneList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneListState();
}

class _ConditionGeneListState extends ConsumerState<ConditionGeneList> {
  /// delete condition gene
  Future<void> _deleteConditionGene(String idConditionGene) async {
    try {
      /// delete
      await ref.watch(conditionGeneChange).deleteConditionGene(idConditionGene);
      Notif(
        text: 'Condition générale supprimée',
        error: false,
      ).notification(context);
    } catch (e) {
      Notif(
        text: 'Une Erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// recupere les conditions
          ref.watch(conditionGeneAllStream).when(
                data: (conditions) {
                  /// si pas de conditions
                  if (conditions.isEmpty) {
                    return Container(
                      child: const Text('Aucune condition'),
                    );
                  }

                  /// si il y a des conditions tableau
                  return array<ConditionGeneSchema?>(
                    context: context,
                    cellsHead: ['Titre', 'Date', 'Test'],
                    cells: conditions
                        .map(
                          (condition) => arrayRow(
                              cells: [
                                condition!.title,
                                '${condition.date!.toDate().day < 10 ? '0${condition.date!.toDate().day}' : '${condition.date!.toDate().day}'}/${condition.date!.toDate().month < 10 ? '0${condition.date!.toDate().month}' : '${condition.date!.toDate().month}'}/${condition.date!.toDate().year}',
                                'btnaction',
                              ],

                              /// action pour voir la condition à modifier
                              onPressedUpdate: () async {
                                /// stream sur la condition
                                ref
                                    .watch(conditionGeneChange)
                                    .streamOneConditionGene(condition.id!);

                                /// recupere l'id de la condition selectionnée
                                ref
                                    .watch(conditionGeneChange)
                                    .setidConditionSelected(condition.id!);
                              },

                              /// action delete
                              onPressedDelete: () async {
                                await _deleteConditionGene(condition.id!);
                              }),
                        )
                        .toList(),
                  );
                },
                error: (error, stack) => WaitingError(
                  messageError: 'Impossible de recuperer les conditions',
                ),
                loading: () => WaitingLoad(),
              ),
        ],
      ),
    );
  }
}
