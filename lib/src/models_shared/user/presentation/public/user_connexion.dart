import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/Input_password/Input_password.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';
import 'package:haimezjohn/src/components/layout_page_public/layout_page_public.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _connexionUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        Notif(
          text: 'Connexion réussis',
          error: false,
        ).notification(context);

        print(FirebaseAuth.instance.currentUser);

        Navigator.popAndPushNamed(context, Routes().profilPrivate);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Notif(
            text: 'Identifiant incorrecte',
            error: true,
          ).notification(context);
        } else if (e.code == 'wrong-password') {
          Notif(
            text: 'Mot de passe incorrecte',
            error: true,
          ).notification(context);
        }
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
            SizedBox(
              width: Responsive.isDesktop(context) ? 500 : double.infinity,
              child: Form(
                key: _formKey,
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
                    InputPassword(
                      labelText: 'Mot de passe',
                      controller: _password,
                      validator: (value) => Validator.validatePassword(
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
            ),
          ],
        ),
      ),
    );
  }
}
