import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/label_input/label_input.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/contact/schema/contact_schema.dart';
import 'package:haimezjohn/src/models/contact/state/contact_provider.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _subTitle = TextEditingController(text: '');
  bool _createUpateChoise = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _title.dispose();
    _subTitle.dispose();
    super.dispose();
  }

  void _changeChoise() {
    setState(() {
      _createUpateChoise = true;
    });
  }

  Future<void> _createUpdateContact(ContactSchema? idContact) async {
    /// creation du contact
    final newContact = ContactSchema(
      subTitle: _subTitle.text.trim(),
      title: _title.text.trim(),
    );

    if (_formKey.currentState!.validate()) {
      try {
        if (_createUpateChoise) {
          /// update
          await ref.watch(contactChange).updateContact(
                idContact!.id!,
                newContact,
              );
        } else {
          /// create
          await ref.watch(contactChange).addContact(newContact);
        }

        Notif(
          text: 'Enregistrement réussi',
          error: true,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Une Erreur est survenu',
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
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// title
            titlePageAdmin(text: 'Contact', context: context),

            /// les inputs
            ref.watch(contactStream).when(
                  data: (contact) {
                    if (contact != null) {
                      _title = TextEditingController(text: contact.title);
                      _subTitle = TextEditingController(text: contact.subTitle);
                      _changeChoise();
                    }

                    return Column(
                      children: [
                        /// input title
                        inputBasic(
                          controller: _title,
                          labelText: 'Titre',
                          validator: (value) =>
                              Validator.validatorInputTextBasic(
                            textError: TextError.inputErrorTitle,
                            value: value,
                          ),
                        ),

                        /// input subtitle
                        labelInput(
                          margin: const EdgeInsets.only(top: 40.0),
                          text: 'Sous titre : ',
                        ),
                        inputBasic(
                          controller: _subTitle,
                          hintText: 'Sous titre',
                          maxLines: 4,
                          validator: (value) =>
                              Validator.validatorInputTextBasic(
                            textError: TextError.inputErrorText,
                            value: value,
                          ),
                        ),

                        /// btn create / update
                        btnElevated(
                          onPressed: () async {
                            await _createUpdateContact(contact);
                          },
                          text: 'Enregistrer',
                        ),
                      ],
                    );
                  },
                  error: (error, stack) => WaitingError(
                    messageError: 'Impossible de récuperer la partie contact',
                  ),
                  loading: () => WaitingLoad(),
                ),
          ],
        ),
      ),
    );
  }
}
