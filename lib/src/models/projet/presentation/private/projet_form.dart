import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_add_update_image/btn_add_update_image.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/projet/presentation/private/projet_form_btn_action.dart';
import 'package:haimezjohn/src/models/projet/schema/projet_schema.dart';
import 'package:haimezjohn/src/models/projet/state/projet_provider.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';
import 'package:haimezjohn/src/utils/upload/upload.dart';

class ProjetForm extends ConsumerStatefulWidget {
  const ProjetForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjetFormState();
}

class _ProjetFormState extends ConsumerState<ProjetForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _lien = TextEditingController(text: '');
  TextEditingController _techno = TextEditingController(text: '');
  TextEditingController _descriptif = TextEditingController(text: '');
  final _uploadFile = Upload();

  @override
  void dispose() {
    _title.dispose();
    _lien.dispose();
    _techno.dispose();
    _descriptif.dispose();
    super.dispose();
  }

  Future<void> projetSave(String idPortfolio, ProjetSchema oldProjet) async {
    if (_formKey.currentState!.validate()) {
      /// creation des données du projets
      final newProjet = ProjetSchema(
        descriptif: _descriptif.text.trim(),
        image: oldProjet.image,
        lien: _lien.text.trim(),
        techno: _techno.text.trim(),
        title: _title.text.trim(),
      );

      /// save dans bdd
      await ref.watch(projetChange).updateProjet(
            idPortfolio,
            oldProjet.id!,
            newProjet,
          );

      Notif(
        text: 'Projet modifié avec succès',
        error: false,
      ).notification(context);
    } else {
      Notif(
        text: 'Impossible de modifier le projet',
        error: true,
      ).notification(context);
    }
  }

  Future<void> _uploadImageProjet(
    ProjetSchema projetSelected,
    String portfolioCurrentId,
  ) async {
    /// selectionne image
    await _uploadFile.selectedImage();

    /// upload image
    await _uploadFile.uploadFile(
      pdf: false,
    );

    _uploadFile.url = await ref
        .watch(projetChange)
        .uploadImageProjet(_uploadFile.file, projetSelected.id!, extension: _uploadFile.extention!);

    /// creation projet
    final newProjet = projetSelected;
    newProjet.image = _uploadFile.url!;

    /// update dans bdd
    await ref.watch(projetChange).updateProjet(
          portfolioCurrentId,
          projetSelected.id!,
          newProjet,
        );

    /// reset upload
    _uploadFile.resetAllVar();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    /// projet selectionné
    final projetSelected = ref.watch(projetSelectedUpdateProvider);
    final projetSelectedIfNull = projetSelected != null;

    final portfolioCurrentId = ref.watch(projetChange).idPortfolioCurrent;

    if (projetSelectedIfNull) {
      _title = TextEditingController(text: projetSelected.title);
      _lien = TextEditingController(text: projetSelected.lien);
      _techno = TextEditingController(text: projetSelected.techno);
      _descriptif = TextEditingController(text: projetSelected.descriptif);
    }

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      margin: const EdgeInsets.only(top: 40.0, bottom: 80.0),
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Form(
        key: _formKey,
        child: projetSelectedIfNull
            ? Column(
                children: [
                  /// btn save + btn close update
                  btnActionFormProjet(
                    onPressedSave: () async {
                      await projetSave(portfolioCurrentId!, projetSelected);
                    },
                    onPressedClose: () {
                      ref.watch(projetChange).resetProjetSelectedUpdate();
                    },
                  ),

                  /// input title
                  inputBasic(
                    controller: _title,
                    labelText: 'Titre du projet',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorTitle,
                      value: value,
                    ),
                  ),

                  /// input descriptif
                  labelInput(
                    margin: const EdgeInsets.only(top: 40.0),
                    text: 'Descriptif du projet :',
                  ),
                  inputBasic(
                    controller: _descriptif,
                    hintText: 'Description du projet',
                    maxLines: 6,
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorText,
                      value: value,
                    ),
                  ),

                  /// input lien
                  inputBasic(
                    controller: _lien,
                    labelText: 'Lien du site',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: 'Veuillez renseigner un lien',
                      value: value,
                    ),
                  ),

                  /// input techno
                  inputBasic(
                    controller: _techno,
                    labelText: 'Les technos utilisées',
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: 'Veuillez renseigner les technos',
                      value: value,
                    ),
                  ),

                  /// btn action image
                  btnAddUpdateImage(
                    margin: const EdgeInsets.only(top: 40.0),
                    alignment: Alignment.centerLeft,
                    message: 'Telecharger une image',
                    onPressed: () async {
                      await _uploadImageProjet(
                          projetSelected, portfolioCurrentId!);
                    },
                  ),

                  /// affichage de l'image
                  displayImage(
                    height: 250,
                    urlE: projetSelected.image,
                    picker: _uploadFile.pickerImage,
                  ),
                ],
              )
            : Container(
                child: const Text('Aucun projet selectionné !'),
              ),
      ),
    );
  }
}
