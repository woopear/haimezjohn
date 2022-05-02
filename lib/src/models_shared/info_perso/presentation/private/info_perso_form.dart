import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models_shared/info_perso/schema/info_perso_schema.dart';
import 'package:haimezjohn/src/models_shared/info_perso/state/info_perso_provider.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class InfoPersoForm extends ConsumerStatefulWidget {
  const InfoPersoForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoPersoFormState();
}

class _InfoPersoFormState extends ConsumerState<InfoPersoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstname = TextEditingController(text: '');
  TextEditingController _lastname = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _codePost = TextEditingController(text: '');
  TextEditingController _city = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _phone = TextEditingController(text: '');
  TextEditingController _age = TextEditingController(text: '');
  TextEditingController _permis = TextEditingController(text: '');

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _address.dispose();
    _codePost.dispose();
    _city.dispose();
    _email.dispose();
    _phone.dispose();
    _age.dispose();
    _permis.dispose();
    super.dispose();
  }

  /// create update infoPerso
  Future<void> _createUpdateInfoPerso(InfoPersoSchema? infoPerso) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// creation info perso
        final newInfoPerso = InfoPersoSchema(
          firstname: _firstname.text.trim(),
          lastname: _lastname.text.trim(),
          address: _address.text.trim(),
          codePost: _codePost.text.trim(),
          city: _city.text.trim(),
          email: _email.text.trim(),
          age: _age.text.trim(),
          permis: _permis.text.trim(),
          phone: _phone.text.trim(),
        );

        /// create dans bdd si infoPerso est null sinon update
        if (infoPerso != null) {
          await ref
              .watch(infoPersoChange)
              .updateInfoPerso(infoPerso.id!, newInfoPerso);
        } else {
          await ref.watch(infoPersoChange).addInfoPerso(newInfoPerso);
        }
        Notif(
          text: 'Infos perso enregistrées avec succès',
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Une Erreur est survenu !',
          error: true,
        ).notification(context);
      }
    } else {
      Notif(
        text: 'Une Erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: _width > 700 ? 600 : double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ref.watch(infoPersoOneStream).when(
                  data: (infoPerso) {
                    if (infoPerso != null) {
                      _firstname =
                          TextEditingController(text: infoPerso.firstname);
                      _lastname =
                          TextEditingController(text: infoPerso.lastname);
                      _address = TextEditingController(text: infoPerso.address);
                      _codePost =
                          TextEditingController(text: infoPerso.codePost);
                      _city = TextEditingController(text: infoPerso.city);
                      _email = TextEditingController(text: infoPerso.email);
                      _phone = TextEditingController(text: infoPerso.phone);
                      _age = TextEditingController(text: infoPerso.age);
                      _permis = TextEditingController(text: infoPerso.permis);
                    }

                    return Container(
                      child: Column(
                        children: [
                          /// input firstname
                          inputBasic(
                            controller: _firstname,
                            labelText: 'Prénom',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Le prénom est obligatoire',
                              value: value,
                            ),
                          ),

                          /// input lastname
                          inputBasic(
                            controller: _lastname,
                            labelText: 'Nom',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Le nom est obligatoire',
                              value: value,
                            ),
                          ),

                          /// input address
                          inputBasic(
                            controller: _address,
                            labelText: 'Adresse',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Adresse obligatoire',
                              value: value,
                            ),
                          ),

                          /// input code postal
                          inputBasic(
                            controller: _codePost,
                            labelText: 'Code postal',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Code postal obligatoire',
                              value: value,
                            ),
                          ),

                          /// input city
                          inputBasic(
                            controller: _city,
                            labelText: 'Ville',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Ville obligatoire',
                              value: value,
                            ),
                          ),

                          /// input email
                          inputBasic(
                            controller: _email,
                            labelText: 'Email',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Email obligatoire',
                              value: value,
                            ),
                          ),

                          /// input phone
                          inputBasic(
                            controller: _phone,
                            labelText: 'Téléphone',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Téléphone obligatoire',
                              value: value,
                            ),
                          ),

                          /// input age
                          inputBasic(
                            controller: _age,
                            labelText: 'Age',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Age obligatoire',
                              value: value,
                            ),
                          ),

                          /// input permis
                          inputBasic(
                            controller: _permis,
                            labelText: 'Phrase pour le permis',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Obligatoire',
                              value: value,
                            ),
                          ),

                          /// btn create/update
                          btnElevated(
                            onPressed: () async {
                              await _createUpdateInfoPerso(infoPerso);
                            },
                            text: 'Enregistrer',
                          ),
                        ],
                      ),
                    );
                  },
                  error: (error, stack) => WaitingError(
                    messageError:
                        'Impossible de récuperer les infos personnelles.',
                  ),
                  loading: () => WaitingLoad(),
                ),
          ],
        ),
      ),
    );
  }
}
