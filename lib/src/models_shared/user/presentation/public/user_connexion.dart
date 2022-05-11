import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/layout_page_public/layout_page_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:haimezjohn/src/utils/mixins/validator.dart';

class UserConnexion extends ConsumerStatefulWidget {
  const UserConnexion({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserConnexionState();
}

class _UserConnexionState extends ConsumerState<UserConnexion> {
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _connexionUser() async {}

  @override
  Widget build(BuildContext context) {
    return layoutPagePublic(
      context: context,
      child: SizedBox(
        width: Responsive.isDesktop(context) ? 700 : double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            /// title
            titleCatPublic(
              title: 'Connexion',
              subTitle: 'Administrateur',
              context: context,
              oneOnOne: true,
              margin: const EdgeInsets.only(
                top: 80,
                bottom: 100,
              ),
            ),

            /// fomulaire de connexion
            Form(
              child: Column(
                children: [
                  /// input mail
                  inputBasic(
                    labelText: 'Identifiant',
                    controller: _email,
                    validator: (value) => Validator.validateEmail(
                      textError: 'Email obligatoire',
                      value: value,
                    ),
                  ),

                  /// input mot de passe
                  inputBasic(
                    labelText: 'Mot de passe',
                    controller: _password,
                    validator: (value) => Validator.validateEmail(
                      textError: 'Mot de passe non renseigné ou non valide',
                      value: value,
                    ),
                  ),

                  /// btn connexion
                  btnElevated(
                    onPressed: () async {
                      await _connexionUser();
                    },
                    text: 'Connexion',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
