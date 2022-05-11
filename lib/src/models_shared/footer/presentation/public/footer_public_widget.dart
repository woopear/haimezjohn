import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models_shared/footer/state/footer_provider.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

class FooterPublicWidget extends ConsumerStatefulWidget {
  const FooterPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FooterPublicWidgetState();
}

class _FooterPublicWidgetState extends ConsumerState<FooterPublicWidget> {
  @override
  Widget build(BuildContext context) {
    final footer = ref.watch(footerOneStream);
    return Container(
      padding: const EdgeInsets.only(top: 30.0),
      width: double.infinity,
      color: Theme.of(context).brightness == Brightness.dark
          ? ColorCustom().inputDark
          : ColorCustom().inputClaire,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// copyright
          footer.when(
            data: (footer) {
              if (footer == null) {
                return Container();
              }
              return Center(
                child: Container(
                  child: Text(
                    '${footer.copyright} ${Timestamp.now().toDate().year}',
                    style: const TextStyle().copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
            error: (error, stack) => WaitingError(
              messageError: 'Impossible de récuperer le footer',
            ),
            loading: () => WaitingLoad(),
          ),

          /// menu link condition gene + connexion admin + autre lien
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// condition gene
                    BtnText(
                        fontSize: 14,
                        message: 'Voir les conditions du site',
                        text: 'Conditions générales',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes().conditionGenePublic,
                          );
                        }),

                    if (FirebaseAuth.instance.currentUser != null)
                    BtnText(
                        fontSize: 14,
                        message: 'Tableau de bord',
                        text: 'Accès admin',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes().profilPrivate,
                          );
                        }),
                  ],
                )
              : Column()
        ],
      ),
    );
  }
}
