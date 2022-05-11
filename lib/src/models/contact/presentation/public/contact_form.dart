import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/models/contact/state/contact_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  bool _validate = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _message = TextEditingController(text: '');

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    _formKey.currentState!.reset();
    super.dispose();
  }

  void resetInput() {
    setState(() {
      _formKey.currentState!.reset();
      _name.clear();
      _email.clear();
      _message.clear();
      _validate = false;
    });
  }

  /// envoie email de contact
  Future<void> _sendMailForWoopear(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      const subject = "Demande de contact accueil woopear";
      await ref
          .watch(contactChange)
          .sendEmailContactClient(subject, _name, _email, _message);

      resetInput();

      /// notification succes
      Notif(
        text: 'Email envoyé',
        error: false,
      ).notification(context);
      setState(() => _isLoading = false);
    } else {
      /// notification error
      Notif(
        text: 'Une erreur est survenu',
        error: true,
      ).notification(context);
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      width: Responsive.isDesktop(context) ? 600 : double.infinity,
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                /// input nom + email
                Column(
                  children: [
                    inputBasic(
                      labelText: 'Nom *',
                      controller: _name,
                      validator: (value) => Validator.validatorInputTextBasic(
                        textError: 'Nom obligatoire',
                        value: value,
                      ),
                    ),
                    inputBasic(
                      labelText: 'E-mail *',
                      controller: _email,
                      validator: (value) => Validator.validatorInputTextBasic(
                        textError: 'Email obligatoire',
                        value: value,
                      ),
                    ),
                  ],
                ),

                /// textarea message
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: TextField(
                    style: GoogleFonts.openSans(fontSize: 20.0),
                    controller: _message,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Votre message *",
                      errorText: _validate ? "Veuillez remplir le champ" : null,
                    ),
                  ),
                ),

                /// btn envoie mail
                btnElevated(
                  isLoading: _isLoading,
                  margin: const EdgeInsets.only(top: 60.0),
                  onPressed: () async {
                    setState(() {
                      _message.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });

                    await _sendMailForWoopear(context);
                  },
                  text: 'Envoyer',
                ),

                /// text info formulaire
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      '* Champ obligatoire',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
