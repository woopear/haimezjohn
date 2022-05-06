import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/presentation/private/article_condition_list_form.dart';
import 'package:haimezjohn/src/models/condition_gene/presentation/private/condition_gene_form.dart';
import 'package:haimezjohn/src/models/condition_gene/presentation/private/condition_gene_list.dart';
import 'package:haimezjohn/src/models/condition_gene/schema/condition_gene_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_provider.dart';

class ConditionGenePagePrivate extends ConsumerStatefulWidget {
  const ConditionGenePagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGenePagePrivateState();
}

class _ConditionGenePagePrivateState
    extends ConsumerState<ConditionGenePagePrivate> {

      /// creation condition gene
  Future<void> _createConditionGene() async {
    try {
      /// creation condition gene
      final newConditionGene = ConditionGeneSchema(
        title: 'Conditions générales',
      );

      /// enregistrement en bdd
      await ref.watch(conditionGeneChange).addConditionGene(newConditionGene);

      Notif(
        text: 'Condition générale créée avec succès',
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 900,
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Column(
                children: [
                  /// title
                  titlePageAdmin(
                    margin: const EdgeInsets.only(bottom: 70.0),
                    text: 'Les conditions générales',
                    context: context,
                  ),

                  /// btn ajouter condition
                  BtnText(
                    text: 'Ajouter une condition',
                    alignment: Alignment.centerLeft,
                    icon: Icons.add_circle_outline_rounded,
                    message: 'Ajouter une condition',
                    onPressed: () async {
                      await _createConditionGene();
                    },
                  ),

                  /// list condition gene
                  const ConditionGeneList(),

                  /// formulaire condition
                  const ConditionGeneForm(),

                  /// list form article condition
                  const ArticleConditionListForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
