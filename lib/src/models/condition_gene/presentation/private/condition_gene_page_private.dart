import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models/condition_gene/presentation/private/condition_gene_list.dart';

class ConditionGenePagePrivate extends ConsumerStatefulWidget {
  const ConditionGenePagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConditionGenePagePrivateState();
}

class _ConditionGenePagePrivateState extends ConsumerState<ConditionGenePagePrivate> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 900,
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Column(
                children: const [
                  /// list condition gene
                  ConditionGeneList(),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}