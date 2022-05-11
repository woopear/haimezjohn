import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_close/btn_close.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/condition_gene/schema/condition_gene_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_provider.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class ConditionGeneForm extends ConsumerStatefulWidget {
  const ConditionGeneForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneFormState();
}

class _ConditionGeneFormState extends ConsumerState<ConditionGeneForm> {
  TextEditingController _title = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  /// update condition selected
  Future<void> _updateConditionSelected(ConditionGeneSchema oldConditionGene) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// creation de la condition
        final newConditionGene = ConditionGeneSchema(
          title: _title.text.trim(),
        );

        /// update dans bdd
        await ref.watch(conditionGeneChange).updateConditionGene(
              oldConditionGene.id!,
              newConditionGene,
            );

        Notif(
          text: 'Condition modifiée avec succès',
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Une Erreur est survenu',
          error: true,
        ).notification(context);
      }
    } else {
      Notif(
        text: 'Une Erreur est survenu, champs obligatoire',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final condition = ref.watch(projetSelectedUpdateProvider);

    if (condition != null) {
      _title = TextEditingController(text: condition.title);
    }

    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: condition != null
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  /// btn close
                  btnClose(
                    alignment: Alignment.centerRight,
                    message: 'Ferme le volet de modification',
                    onPressed: () {
                      ref.watch(conditionGeneChange).resetConditionSelected();
                    },
                  ),

                  /// title label
                  labelInput(
                    text: 'Condition : ${condition.title} N° ${condition.id}',
                  ),

                  /// input title
                  inputBasic(
                    controller: _title,
                    labelText: 'Titre de la condition',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: 'Champs obligatoire',
                      value: value,
                    ),
                  ),

                  /// btn update
                  btnElevated(
                    text: 'Enregistrer',
                    onPressed: () async {
                      await _updateConditionSelected(condition);
                    },
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: const Text('Aucune selection'),
            ),
    );
  }
}
