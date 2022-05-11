import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_delete_one/btn_delete_one.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/schema/article_condition_schema.dart';
import 'package:haimezjohn/src/models/condition_gene/models/article_condition/state/article_condition_provider.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class ArticleConditionForm extends ConsumerStatefulWidget {
  String idConditionGeneSelected;
  ArticleConditionSchema article;

  ArticleConditionForm({
    Key? key,
    required this.idConditionGeneSelected,
    required this.article,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleConditionFormState();
}

class _ArticleConditionFormState extends ConsumerState<ArticleConditionForm> {
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _text = TextEditingController(text: '');
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    if (mounted) {
      _title.dispose();
      _text.dispose();
      super.dispose();
    }
  }

  /// modification de l'article
  Future<void> _updateArticle() async {
    if (_formkey.currentState!.validate()) {
      try {
        /// creation de l'article
        final newArticleConditionGene = ArticleConditionSchema(
          text: _text.text.trim(),
          title: _title.text.trim(),
        );

        /// enregistrement en bdd
        await ref.watch(articleConditionChange).updateArticleCondition(
              widget.idConditionGeneSelected,
              widget.article.id!,
              newArticleConditionGene,
            );

        Notif(
          text: "Article modifier avec succès",
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: "Impossible de modifer l'article",
          error: true,
        ).notification(context);
      }
    } else {
      Notif(
        text: "Impossible de modifer l'article",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _title = TextEditingController(text: widget.article.title);
    _text = TextEditingController(text: widget.article.text);

    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            const Divider(
              height: 50.0,
            ),

            /// btn delete
            btnDeleteOne(
              onPressed: () async {
                /// delete
                await ref.watch(articleConditionChange).deleteArticleCondition(
                      widget.idConditionGeneSelected,
                      widget.article.id!,
                    );
              },
              message: "Supprimer l'article",
              alignment: Alignment.centerLeft,
            ),

            /// title du formulaire
            labelInput(
              text: 'Article : ${widget.article.title}',
            ),

            /// input title
            inputBasic(
              controller: _title,
              labelText: "Titre de l'article",
              validator: (value) => Validator.validatorInputTextBasic(
                textError: 'Champs obligatoire',
                value: value,
              ),
            ),

            /// input text
            labelInput(
                text: "Contenu de l'article :",
                margin: const EdgeInsets.only(top: 20.0)),
            inputBasic(
              controller: _text,
              hintText: "Votre texte",
              maxLines: 8,
              validator: (value) => Validator.validatorInputTextBasic(
                textError: 'Champs obligatoire',
                value: value,
              ),
            ),

            /// btn update
            btnElevated(
              onPressed: () async {
                await _updateArticle();
              },
              text: 'Enregistrer',
            ),
          ],
        ),
      ),
    );
  }
}
