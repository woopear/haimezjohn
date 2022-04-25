import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_form_btn_action.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';

class TechnoForm extends ConsumerStatefulWidget {
  const TechnoForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechnoFormState();
}

class _TechnoFormState extends ConsumerState<TechnoForm> {
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _text = TextEditingController(text: '');

  Future<void> updateTechno(String idTechno) async {
    try {
      /// creation techno
      final newTechno = TechnoSchema(
        image: '',
        text: _text.text.trim(),
        title: _title.text.trim(),
      );

      /// update techno bdd
      await ref.watch(technoChange).updateTechno(
          ref.watch(competenceChange).idCompetence!, idTechno, newTechno);

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
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    /// stream techno selected
    final techno = ref.watch(technoSelectedUpdateProvider);

    if (techno != null) {
      _title = TextEditingController(text: techno.title);
      _text = TextEditingController(text: techno.text);
    }

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      margin: const EdgeInsets.only(
          top: 0.0, left: 30.0, right: 30.0, bottom: 70.0),
      child: Form(
        child: techno != null
            ? Column(
                children: [
                  /// btn save + btn fermer volet update techno (delete technoSelected)
                  btnActionFormTechno(
                    onPressedSave: () async {
                      await updateTechno(techno.id!);
                    },
                    onPressedClose: () {
                      ref.watch(technoChange).resetTechnoSelected();
                    },
                  ),

                  /// input title
                  inputBasic(
                      labelText: 'Titre de la techno', controller: _title),

                  /// input text
                  labelInput(
                      margin: const EdgeInsets.only(top: 40.0),
                      text: 'Detail de la techno :'),
                  inputBasic(
                    hintText: 'Votre texte',
                    controller: _text,
                    maxLines: 6,
                  ),

                  /// todo input image
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
