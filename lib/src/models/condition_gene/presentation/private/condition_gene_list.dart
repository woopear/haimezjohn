import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/array/array.dart';
import 'package:haimezjohn/src/components/array/array_row.dart';
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
                              'date',
                              'btnaction',
                            ],
                          ),
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
