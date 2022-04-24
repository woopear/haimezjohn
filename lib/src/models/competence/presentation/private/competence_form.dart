import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/competence/schema/competence_schema.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_provider.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class CompetenceForm extends ConsumerStatefulWidget {
  const CompetenceForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompetenceFormState();
}

class _CompetenceFormState extends ConsumerState<CompetenceForm> {
  final _formKey = GlobalKey<FormState>();

  /// input
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _subTitle = TextEditingController(text: '');

  @override
  void dispose() {
    _title.dispose();
    _subTitle.dispose();
    super.dispose();
  }

  /// pour image
  dynamic _file;
  String? _extention;
  String? _url;
  String? _urlPdf;
  FilePickerResult? _picker;
  FilePickerResult? _pickerPdf;

  void resetValueImagePdf() {
    setState(() {
      _file = null;
      _extention = null;
      _url = null;
      _urlPdf = null;
      _picker = null;
      _pickerPdf = null;
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

  /// creation conteneur pour fichier
  Future<void> _selectPdf() async {
    if (kIsWeb) {
      final file = await FilePicker.platform.pickFiles();
      setState(() {
        _pickerPdf = file;
      });
    } else {
      final file = await FilePicker.platform.pickFiles(allowMultiple: false);
      setState(() async {
        _pickerPdf = file;
      });
    }
  }

  /// upload image
  Future<void> _uploadFile(bool pdf) async {
    /// si web sinon le reste
    if (kIsWeb) {
      if (!pdf) {
        /// on recupere le path
        setState(() {
          _file = _picker!.files.first.bytes;
          _extention = _picker!.files.first.extension;
        });
        _url = await ref
            .watch(uploadFileChange)
            .uploadImageCompetence(_file, extension: _extention!);
      } else {
        /// on recupere le path
        setState(() {
          _file = _pickerPdf!.files.first.bytes;
          _extention = _pickerPdf!.files.first.extension;
        });
        _urlPdf = await ref
            .watch(uploadFileChange)
            .uploadPdfCompetence(_file, extension: _extention!);
      }
    } else {
      if (_picker == null) return;

      /// on recupere le fichier
      setState(() {
        _file = File(_picker!.files.single.path!);
      });

      if (!pdf) {
        _url = await ref.watch(uploadFileChange).uploadImageCompetence(_file);
      } else {
        _urlPdf = await ref.watch(uploadFileChange).uploadPdfCompetence(_file);
      }
    }
  }

  /// creation ou modification competence
  Future<void> createUpdateCompetence(CompetenceSchema? oldCompetence) async {
    try {
      /// enregistrement des fichiers image et pdf
      /// affectation des variables urls
      if (_picker != null) {
        await _uploadFile(false);
      }

      if (_pickerPdf != null) {
        await _uploadFile(true);
      }

      /// creation en BDD
      if (oldCompetence != null) {
        /// creation nouvelle competence
        /// assignation des urls
        CompetenceSchema newCompetence = CompetenceSchema(
          title: _title.text.trim(),
          subTitle: _subTitle.text.trim(),
          image: _url ?? oldCompetence.image,
          cvPdf: _urlPdf ?? oldCompetence.cvPdf,
        );

        /// update
        await ref
            .watch(competenceChange)
            .updateCompetence(oldCompetence.id!, newCompetence);
      } else {
        /// creation nouvelle competence
        /// assignation des urls
        CompetenceSchema newCompetence = CompetenceSchema(
          title: _title.text.trim(),
          subTitle: _subTitle.text.trim(),
          image: _url ?? Globals.urlAucuneImage,
          cvPdf: _urlPdf ?? '',
        );

        /// create
        await ref.watch(competenceChange).addCompetence(newCompetence);
      }

      resetValueImagePdf();

      /// notif succes
      Notif(
        text: 'Enregistrement complet !',
        error: false,
      ).notification(context);
    } catch (e) {
      Notif(
        text: 'Une Erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  Future<void> deleteImageCompetence(CompetenceSchema oldCompetence) async {
    try {
      /// suppression image
      await ref
          .watch(uploadFileChange)
          .deleteImage(Globals.adresseStorageImageCompetence);

      final newCompetence = oldCompetence;
      newCompetence.image = '';

      await ref
          .watch(competenceChange)
          .updateCompetence(oldCompetence.id!, newCompetence);

      /// notif succes
      Notif(
        text: 'Image competence supprimée',
        error: false,
      ).notification(context);
    } catch (e) {
      Notif(
        text: 'Une Erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  Future<void> deletePdfCompetence(CompetenceSchema oldCompetence) async {
    try {
      /// suppression image
      await ref
          .watch(uploadFileChange)
          .deleteImage(Globals.adresseStoragePdfCompetence);

      final newCompetence = oldCompetence;
      newCompetence.cvPdf = '';

      await ref
          .watch(competenceChange)
          .updateCompetence(oldCompetence.id!, newCompetence);

      /// notif succes
      Notif(
        text: 'Pdf competence supprimée',
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
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ref.watch(competencesStream).when(
                  data: (competences) {
                    CompetenceSchema? competence;
                    if (competences.isNotEmpty) {
                      competence = competences[0];
                      _title = TextEditingController(text: competence.title);
                      _subTitle =
                          TextEditingController(text: competence.subTitle);
                    }

                    return Container(
                      child: Column(
                        children: [
                          /// input title
                          inputBasic(
                            labelText: "Titre",
                            controller: _title,
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: TextError.inputErrorTitle,
                              value: value,
                            ),
                          ),

                          /// input subTitle
                          labelInput(
                            text: "Sous titre :",
                            margin: const EdgeInsets.only(top: 30.0),
                          ),
                          inputBasic(
                            controller: _subTitle,
                            hintText: "Sous titre de la compétence",
                            maxLines: 4,
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: TextError.inputErrorText,
                              value: value,
                            ),
                          ),

                          /// telecharger image cv
                          labelInput(
                            text: "Image CV",
                            margin: const EdgeInsets.only(top: 30.0),
                          ),
                          Row(
                            children: [
                              /// btn add update image
                              btnAddUpdateImage(
                                alignment: Alignment.centerLeft,
                                onPressed: () async {
                                  await _selectImage();
                                },
                                message: "Image CV",
                                iconSize: 40.0,
                              ),

                              /// delete image
                              btnDeleteOne(
                                onPressed: () async {
                                  if (competence!.image != '') {
                                    await deleteImageCompetence(competence);
                                  }
                                  setState(() {
                                    _picker = null;
                                  });
                                },
                                message: "Supprimer l'image",
                                iconSize: 40.0,
                              ),
                            ],
                          ),

                          /// affichage image
                          displayImage(
                            height: 250,
                            urlE: competence!.image,
                            picker: _picker,
                            margin: const EdgeInsets.only(bottom: 50.0),
                          ),

                          /// si pdf enregistrer
                          competence.cvPdf != ''
                              ? Container(
                                  margin: const EdgeInsets.only(top: 50.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      labelInput(
                                        text: 'Vous avez déja une version pdf',
                                      ),

                                      /// delete pdf
                                      btnDeleteOne(
                                        onPressed: () async {
                                          if (competence!.image != '') {
                                            await deletePdfCompetence(
                                                competence);
                                          }
                                          setState(() {
                                            _pickerPdf = null;
                                          });
                                        },
                                        margin:
                                            const EdgeInsets.only(left: 20.0),
                                        message: "Supprimer le pdf existant",
                                        iconSize: 30.0,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),

                          /// partie telechargement cv pdf
                          Row(
                            children: [
                              BtnText(
                                text: _pickerPdf != null
                                    ? "1 fichier en attente d'enregistrement"
                                    : competence.cvPdf != ''
                                        ? 'Modifier la version pdf'
                                        : 'Télécharger la version pdf',
                                message: 'Télécharger la version pdf',
                                icon: Icons.file_download_outlined,
                                onPressed: () async {
                                  await _selectPdf();
                                },
                              ),
                              _pickerPdf != null
                                  ? btnDeleteOne(
                                      onPressed: () {
                                        setState(() {
                                          _pickerPdf = null;
                                        });
                                      },
                                      message: 'annuler le document téléchargé')
                                  : Container(),
                            ],
                          ),

                          /// btn creer ou modifier
                          btnElevated(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, top: 40.0),
                            onPressed: () async {
                              await createUpdateCompetence(competence);
                            },
                            text: 'Enregistrer',
                          ),

                          /// btn ajoute techno
                          BtnText(
                            text: 'Ajouter une techno',
                            onPressed: () async {
                              final newTechno = TechnoSchema(
                                  image: "",
                                  text: "",
                                  title: "Pas encore de titre");
                              await ref
                                  .watch(technoChange)
                                  .addTechno(competence!.id!, newTechno);
                            },
                            icon: Icons.add_circle_outline_rounded,
                            message: 'ajouter une techno',
                          ),
                        ],
                      ),
                    );
                  },
                  error: (error, stack) =>
                      WaitingError(messageError: "Une erreur est survenu"),
                  loading: () => WaitingLoad(),
                ),
          ],
        ),
      ),
    );
  }
}
