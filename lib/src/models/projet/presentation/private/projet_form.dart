import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/projet/presentation/private/projet_form_btn_action.dart';
import 'package:haimezjohn/src/models/projet/state/projet_provider.dart';

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

  @override
  void dispose() {
    _title.dispose();
    _lien.dispose();
    _techno.dispose();
    _descriptif.dispose();
  }

  Future<void> projetSave() async {}

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    /// projet selectionné
    final projetSelected = ref.watch(projetSelectedUpdateProvider);
    final projetSelectedIfNull = projetSelected != null;

    if (projetSelectedIfNull) {
      _title = TextEditingController(text: projetSelected.title);
      _lien = TextEditingController(text: projetSelected.lien);
      _techno = TextEditingController(text: projetSelected.techno);
      _descriptif = TextEditingController(text: projetSelected.descriptif);
    }

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      margin: const EdgeInsets.only(top: 40.0, bottom: 70.0),
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Form(
        child: projetSelectedIfNull
            ? Column(
                children: [
                  /// btn save + btn close update
                  btnActionFormProjet(
                    onPressedSave: () async {
                      await projetSave();
                    },
                    onPressedClose: () {
                      ref.watch(projetChange).resetProjetSelectedUpdate();
                    },
                  ),

                  /// input title
                  inputBasic(
                    controller: _title,
                    labelText: 'Titre du projet',
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
                  ),

                  /// input lien
                  inputBasic(
                    controller: _lien,
                    labelText: 'Lien du site',
                  ),

                  /// input techno
                  inputBasic(
                    controller: _techno,
                    labelText: 'Les technos utilisées',
                  ),

                  /// gestion image
                ],
              )
            : Container(
                child: const Text('Aucun projet selectionné !'),
              ),
      ),
    );
  }
}
