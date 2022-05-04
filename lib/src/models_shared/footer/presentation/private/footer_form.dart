import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models_shared/footer/schema/footer_schema.dart';
import 'package:haimezjohn/src/models_shared/footer/state/footer_provider.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class FooterForm extends ConsumerStatefulWidget {
  const FooterForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterFormState();
}

class _FooterFormState extends ConsumerState<FooterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _copyright = TextEditingController(text: '');

  @override
  void dispose() {
    _copyright.dispose();
    super.dispose();
  }

  /// create update footer
  Future<void> _createUpdateFooter(FooterSchema? footer) async {
    if (_formKey.currentState!.validate()) {
      try {
        /// creation du footer
        final newFooter = FooterSchema(
          copyright: _copyright.text.trim(),
        );

        /// si footer est different de nul on update sinon on create
        if (footer != null) {
          await ref.watch(footerChange).updateFooter(footer.id!, newFooter);
        } else {
          await ref.watch(footerChange).addFooter(newFooter);
        }
        Notif(
          text: 'Footer enregistré avec succès',
          error: false,
        ).notification(context);
      } catch (e) {
        Notif(
          text: 'Impossible de modifier le footer',
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

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: _width > 700 ? 600 : double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ref.watch(footerOneStream).when(
                  data: (footer) {
                    if (footer != null) {
                      _copyright =
                          TextEditingController(text: footer.copyright);
                    }
                    return Container(
                      child: Column(
                        children: [
                          /// input copyright
                          inputBasic(
                            controller: _copyright,
                            labelText: 'Copyright du site',
                            validator: (value) =>
                                Validator.validatorInputTextBasic(
                              textError: 'Champ obligatoire',
                              value: value,
                            ),
                          ),

                          /// btn create / update
                          btnElevated(
                            onPressed: () async {
                              await _createUpdateFooter(footer);
                            },
                            text: 'Enregistrer',
                          ),
                        ],
                      ),
                    );
                  },
                  error: (error, stack) => WaitingError(
                    messageError: 'Impossible de récuperer le footer',
                  ),
                  loading: () => WaitingLoad(),
                ),
          ],
        ),
      ),
    );
  }
}
