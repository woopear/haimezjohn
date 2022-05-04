import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/notif/notif.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/link/presentation/private/link_form_update.dart';
import 'package:haimezjohn/src/models/link/schema/link_schema.dart';
import 'package:haimezjohn/src/models/link/state/link_provider.dart';

class LinkPagePrivate extends ConsumerStatefulWidget {
  const LinkPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LinkPagePrivateState();
}

class _LinkPagePrivateState extends ConsumerState<LinkPagePrivate> {
  Future<void> _createLink() async {
    try {
      /// creation du lien
      final newLink = LinkSchema(name: 'Aucun nom', link: '');

      /// creation en bdd
      await ref.watch(linkChange).addLink(newLink);

      /// notif succès
      Notif(
        text: 'Lien créé avec succès',
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 900,
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Column(
                children: [
                  /// title
                  titlePageAdmin(text: 'Les liens', context: context),

                  /// btn creer link
                  BtnText(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 70.0, top: 20.0),
                    text: 'Créer un lien',
                    icon: Icons.add_circle_outline_rounded,
                    message: 'Créer un lien',
                    onPressed: () async {
                      await _createLink();
                    },
                  ),

                  /// list de formulaire link
                  ref.watch(linkAllStream).when(
                        data: (links) {
                          if (links.isEmpty) {
                            return Container(
                              child: const Text('Aucun lien'),
                            );
                          }

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: links.length,
                            itemBuilder: (context, index) {
                              final link = links[index];
                              return LinkFormUpdate(link: link,);
                            },
                          );
                        },
                        error: (error, stack) => WaitingError(
                          messageError: 'Impossible de récuperer les liens.',
                        ),
                        loading: () => WaitingLoad(),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
