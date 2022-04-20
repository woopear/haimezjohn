import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/models/profil/state/profil_provider.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_provider.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class ProfilUpdateForm extends ConsumerStatefulWidget {
  bool created;

  ProfilUpdateForm({
    Key? key,
    this.created = false,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilUpdateFormState();
}

class _ProfilUpdateFormState extends ConsumerState<ProfilUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// input
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _text = TextEditingController(text: '');

  @override
  void didChangeDependencies() {
    if (_scaffoldKey.currentContext != null) {
      _scaffoldKey.currentContext!.dependOnInheritedWidgetOfExactType();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  /// pour image
  dynamic _file;
  String? _extention;
  String? _url;
  FilePickerResult? _picker;

  /// reset input
  void resetInput() {
    _formKey.currentState!.reset();
    _title.clear();
    _text.clear();
    _file = null;
    _extention = null;
    _url = null;
    _picker = null;
  }

  /// reset variable image
  void resetValueImage() {
    _file = null;
    _extention = null;
    _url = null;
    _picker = null;
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
  Future<void> _uploadImage() async {
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

      _url = await ref
          .watch(uploadFileChange)
          .uploadImageProfil(_file, extension: _extention!);
    } else {
      if (_picker == null) return;

      /// on recupere le fichier
      setState(() {
        _file = File(_picker!.files.single.path!);
      });

      _url = await ref.watch(uploadFileChange).uploadImageProfil(_file);
    }
  }

  /// creation profil
  Future<void> _creationProfil(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// si input image contient une image
      /// on enregistre l'image et on recupere l'url
      if (_picker != null) {
        await _uploadImage();
      }

      

      /// creation objet
      /// si url != null on met l'url dans image
      /// sinon on met ''
      final newProfil = ProfilSchema(
        title: _title.text.trim(),
        text: _text.text.trim(),
        image: _url ?? '',
      );

      /// creation bdd
      await ref.watch(profilChange).addProfil(newProfil);

    } else {
      /// notification error
      Notif(
        text: Globals.messageErrorCreateProfil,
        error: true,
      ).notification(context);
    }
  }

  /// update présentation
  Future<void> _updatePresentation(ProfilSchema oldProfil) async {
    if (_formKey.currentState!.validate()) {
      /// creation objet
      final newPresentation = ProfilSchema(
        title: _title.text.trim(),
        text: _text.text.trim(),
        image: oldProfil.image,
      );

      /// creation bdd de la
      await ref
          .watch(profilChange)
          .updateProfil(oldProfil.id!, newPresentation);

      /// notification succes
      Notif(
        text: Globals.messageSuccesUpdateProfil,
        error: false,
      ).notification(context);

      resetValueImage();
    } else {
      resetValueImage();

      /// notification error
      Notif(
        text: Globals.messageErrorUpdateProfil,
        error: true,
      ).notification(context);
    }
  }

  /// update image en directe BDD
  Future<void> _updateImageDirectly(ProfilSchema oldProfil) async {
    if (_formKey.currentState!.validate()) {
      /// selection image
      await _selectImage();

      /// upload image
      await _uploadImage();

      /// creation objet
      final newProfil = oldProfil;
      newProfil.image = _url ?? '';

      /// update bdd
      await ref.watch(profilChange).updateProfil(oldProfil.id!, newProfil);

      /// notif succes
      Notif(
        text: Globals.messageSuccesImageProfil,
        error: false,
      ).notification(context);

      resetValueImage();
    } else {
      resetValueImage();

      /// notif error
      Notif(
        text: Globals.messageErrorImageProfil,
        error: false,
      ).notification(context);
    }
  }

  /// suppression image
  Future<void> _deleteImageDirectly(ProfilSchema oldProfil) async {
    if (_formKey.currentState!.validate()) {
      /// supprimer proprieter image
      final newProfil = oldProfil;
      newProfil.image = '';
      await ref.watch(profilChange).updateProfil(oldProfil.id!, newProfil);

      /// suppression de l'image dans storage
      await ref
          .watch(uploadFileChange)
          .deleteImage(Globals.adresseStorageProfil);

      /// notif succes
      Notif(
        text: Globals.messageSuccesImageDelProfil,
        error: false,
      ).notification(context);

      resetValueImage();
    } else {
      resetValueImage();

      /// notif error
      Notif(
        text: Globals.messageErrorImageProfil,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    ProfilSchema? profil;
    ref.watch(profilsStream).whenData((value) {
      _title = TextEditingController(text: value[0].title);
      _text = TextEditingController(text: value[0].text);
      profil = value[0];
      
    });

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input image
            Container(
              child: Column(
                children: [
                  /// label input
                  labelInput(text: Globals.labelImageProfil),

                  /// btn telecharger/modifier image + supprimer
                  Container(
                    child: Row(
                      children: [
                        /// ajouter/modifier
                        btnAddUpdateImage(
                          margin: const EdgeInsets.all(0.0),
                          message: Globals.btnAddUpdateImageProfil,
                          onPressed: () async {
                            if (widget.created) {
                              await _selectImage();
                            } else {
                              
                              if (profil != null) {
                                await _updateImageDirectly(profil!);
                              }
                            }
                          },
                        ),

                        /// delete image
                        btnDeleteOne(
                          margin: const EdgeInsets.only(left: 10.0),
                          message: Globals.btnDeleteOneProfil,
                          onPressed: () async {
                            if (profil != null) {
                              await _deleteImageDirectly(profil!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  /// affichage image en cours
                  displayImage(
                    urlE: profil != null ? profil!.image : '',
                    height: 200,
                    picker: _picker,
                  ),
                ],
              ),
            ),

            /// TODO : regler bug creation

            /// title
            inputBasic(
                controller: _title,
                labelText: Globals.inputTitle,
                validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorTitle,
                      value: value,
                    )),

            /// text
            inputBasic(
                controller: _text,
                hintText: Globals.inputTextContent,
                maxLines: 7,
                validator: (value) => Validator.validatorInputTextBasic(
                      textError: TextError.inputErrorText,
                      value: value,
                    )),

            /// btn save
            btnElevated(
              text: widget.created
                  ? Globals.btnElevatedCreerProfil
                  : Globals.btnElevatedUpdateProfil,
              onPressed: () async {
                if (widget.created) {
                  await _creationProfil(context);
                } else {
                  if (profil != null) {
                    await _updatePresentation(profil!);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
