import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_add_update_image/btn_add_update_image.dart';
import 'package:haimezjohn/src/components/btn_delete_one/btn_delete_one.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_form_btn_action.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class TechnoForm extends ConsumerStatefulWidget {
  const TechnoForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechnoFormState();
}

class _TechnoFormState extends ConsumerState<TechnoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _text = TextEditingController(text: '');

  /// pour image
  dynamic _file;
  String? _extention;
  String? _url;
  FilePickerResult? _picker;

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  /// reset les variable simples
  void _resetValueImage() {
    setState(() {
      _file = null;
      _extention = null;
      _url = null;
      _picker = null;
    });
  }

  /// creation conteneur pour fichier
  Future<void> _selectImage() async {
    if (kIsWeb) {
      final file = await FilePicker.platform.pickFiles();
      setState(() {
        _picker = file;
      });
    } else {
      final file = await FilePicker.platform.pickFiles(allowMultiple: false);
      setState(() async {
        _picker = file;
      });
    }
  }

  /// upload image
  Future<void> _uploadImage(String idTechno) async {
    /// si web sinon le reste
    if (kIsWeb) {
      if (_picker == null) {
        /// notification error
        Notif(
          text: Globals.messageErrorImageProfil,
          error: true,
        ).notification(context);
        throw Exception(Globals.messageErrorImageProfil);
      }

      /// on recupere le path
      setState(() {
        _file = _picker!.files.first.bytes;
        _extention = _picker!.files.first.extension;
      });

      _url = await ref.watch(uploadFileChange).uploadImageTechno(
            _file,
            extension: _extention!,
            idTechno: idTechno,
          );
    } else {
      if (_picker == null) return;

      /// on recupere le fichier
      setState(() {
        _file = File(_picker!.files.single.path!);
      });

      _url = await ref.watch(uploadFileChange).uploadImageTechno(
            _file,
            idTechno: idTechno,
          );
    }
  }

  /// delete image
  Future<void> _deleteImageTechno(TechnoSchema techno) async {
    try {
      /// delete image bdd
      await ref
          .watch(uploadFileChange)
          .deleteImage('${Globals.adresseStorageImageTechno}${techno.id}');

      final newTechno = techno;
      newTechno.image = "";

      /// update techno
      await ref.watch(technoChange).updateTechno(
          ref.watch(competenceChange).idCompetence!, techno.id!, newTechno);
    } catch (e) {
      Notif(
        text: 'Impossible de modifier la techno',
        error: true,
      ).notification(context);
    }
  }

  /// update une techno
  Future<void> _updateTechno(TechnoSchema oldTechno) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// creation techno
        final newTechno = TechnoSchema(
          image: oldTechno.image,
          text: _text.text.trim(),
          title: _title.text.trim(),
        );

        /// si image picker renseigné
        if (_picker != null) {
          await _uploadImage(oldTechno.id!);
        }

        /// si url est different de nul on affecte
        if (_url != null) {
          newTechno.image = _url!;
        }

        /// update techno bdd
        await ref.watch(technoChange).updateTechno(
            ref.watch(competenceChange).idCompetence!, oldTechno.id!, newTechno);

        /// reset variable image + reset validate formKay
        _resetValueImage();
        _formKey.currentState!.reset();

        Notif(
          text: 'Techno modifiée avec succès',
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Impossible de modifier la techno',
          error: true,
        ).notification(context);
      }
    } else {
      Notif(
        text: 'Veuillez remplir tous les champs',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    /// stream techno selected
    final techno = ref.watch(technoSelectedUpdateProvider);

    if (techno != null) {
      _title = TextEditingController(text: techno.title);
      _text = TextEditingController(text: techno.text);
    }

    return Container(
      width: Responsive.isMobile(context) ? 600 : double.infinity,
      margin: const EdgeInsets.only(
          top: 0.0, left: 30.0, right: 30.0, bottom: 70.0),
      child: Form(
        key: _formKey,
        child: techno != null
            ? Column(
                children: [
                  /// btn save + btn fermer volet update techno (delete technoSelected)
                  btnActionFormTechno(
                    onPressedSave: () async {
                      await _updateTechno(techno);
                    },
                    onPressedClose: () {
                      ref.watch(technoChange).resetTechnoSelected();
                    },
                  ),

                  /// input title
                  inputBasic(
                    labelText: 'Titre de la techno',
                    controller: _title,
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorTitle,
                      value: value,
                    ),
                  ),

                  /// input text
                  labelInput(
                      margin: const EdgeInsets.only(top: 40.0),
                      text: 'Detail de la techno :'),
                  inputBasic(
                    hintText: 'Votre texte',
                    controller: _text,
                    maxLines: 6,
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorText,
                      value: value,
                    ),
                  ),

                  Row(
                    children: [
                      /// btn select image
                      btnAddUpdateImage(
                          onPressed: () => _selectImage(),
                          message: 'ajouter une image'),

                      /// btn delete image
                      btnDeleteOne(
                        onPressed: () async {
                          /// reset variable image
                          _resetValueImage();

                          /// delete dans bdd
                          if (techno.image != '') {
                            await _deleteImageTechno(techno);
                          }
                        },
                        message: "supprimer l'image",
                      ),
                    ],
                  ),

                  /// display image ou picker
                  displayImage(
                    urlE: techno.image != '' ? techno.image : '',
                    picker: _picker,
                  ),
                ],
              )
            : Container(
                margin: const EdgeInsets.only(top: 50.0, bottom: 70.0),
                child: const Text('Aucune techno selectionnée'),
              ),
      ),
    );
  }
}
