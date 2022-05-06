import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/title_cat_admin/title_cat_admin.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/presentation/private/article_condition_form.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/schema/article_condition_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/state/article_condition_provider.dart';
import 'package:haimezjohn/src/models/condition_gene/state/condition_gene_provider.dart';

class ArticleConditionListForm extends ConsumerStatefulWidget {
  const ArticleConditionListForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleConditionListFormState();
}

class _ArticleConditionListFormState
    extends ConsumerState<ArticleConditionListForm> {
  /// create article
  Future<void> _createArticleCondition(
    String idConditionGeneSelected,
  ) async {
    try {
      /// creation de l'article
      final newArticleConditionGene = ArticleConditionSchema(
        text: '',
        title: 'Sans titre',
      );

      /// enregistrement dans la bdd
      await ref.watch(articleConditionChange).addArticleCondition(
            idConditionGeneSelected,
            newArticleConditionGene,
          );

      Notif(
        text: "Article créé avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      Notif(
        text: "Impossible de créer l'article",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// id de la condition selectionné
    final idConditionGeneSelected = ref.watch(idConditionGeneProvider);

    return Container(
      child: Column(
        children: [
          /// title + btn create article
          idConditionGeneSelected != null
              ? Column(
                  children: [
                    titleCatAdmin(
                      text: 'Articles de la condition',
                      context: context,
                    ),
                    BtnText(
                      margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      text: 'Ajouter un article',
                      message: 'Ajouter un article',
                      alignment: Alignment.centerLeft,
                      icon: Icons.add_circle_outline_rounded,
                      onPressed: () async {
                        await _createArticleCondition(idConditionGeneSelected);
                      },
                    ),
                  ],
                )
              : Container(),

          /// list si condition selectionné
          idConditionGeneSelected != null
              ? ref
                  .watch(articleConditionAllStream(idConditionGeneSelected))
                  .when(
                    data: (articles) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: ((context, index) {
                          return ArticleConditionForm(
                            article: articles[index],
                            idConditionGeneSelected: idConditionGeneSelected,
                          );
                        }),
                      );
                    },
                    error: (error, stack) => WaitingError(
                      messageError: 'Impossible de recuperer les articles',
                    ),
                    loading: () => WaitingLoad(),
                  )
              : Container(),
        ],
      ),
    );
  }
}
