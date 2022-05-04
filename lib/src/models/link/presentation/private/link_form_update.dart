import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_delete_one/btn_delete_one.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/models/link/state/link_provider.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class LinkFormUpdate extends ConsumerStatefulWidget {
  LinkSchema? link;

  LinkFormUpdate({Key? key, this.link}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkFormUpdateState();
}

class _LinkFormUpdateState extends ConsumerState<LinkFormUpdate> {
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _link = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _link.dispose();
    super.dispose();
  }

  /// update link
  Future<void> _updateLink(LinkSchema oldLink) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// create du lien
        final newLink = LinkSchema(
          name: _name.text.trim(),
          link: _link.text.trim(),
        );

        /// modification en bdd du lien
        await ref.watch(linkChange).updateLink(oldLink.id!, newLink);

        /// succes
        Notif(
          text: 'Lien modifié avec succès',
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Une erreur est survenu',
          error: true,
        ).notification(context);
      }
    } else {
      Notif(
        text: 'Une erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  /// delete link
  Future<void> _deleteLink(String idLink) async {
    try {
      /// delete
      await ref.watch(linkChange).deleteLink(idLink);
      Notif(
        text: 'Impossible de supprimer le lien',
        error: false,
      ).notification(context);
    } catch (e) {
      Notif(
        text: 'Impossible de supprimer le lien',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.link != null) {
      _name = TextEditingController(text: widget.link!.name);
      _link = TextEditingController(text: widget.link!.link);
    }
    return widget.link != null
        ? Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// title du formulaire
                  labelInput(text: 'Lien : ${widget.link!.name}'),

                  /// btn delete
                  btnDeleteOne(
                    alignment: Alignment.centerLeft,
                    onPressed: () async {
                      await _deleteLink(widget.link!.id!);
                    },
                    message: 'Supprimer le lien',
                  ),

                  /// input name
                  inputBasic(
                    controller: _name,
                    labelText: 'nom du lien',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: 'Champs obligatoire',
                      value: value,
                    ),
                  ),

                  /// input link
                  inputBasic(
                    controller: _link,
                    labelText: 'le lien',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: 'Champs obligatoire',
                      value: value,
                    ),
                  ),

                  /// btn update
                  btnElevated(
                    onPressed: () async {
                      await _updateLink(widget.link!);
                    },
                    text: 'Enregistrer',
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
