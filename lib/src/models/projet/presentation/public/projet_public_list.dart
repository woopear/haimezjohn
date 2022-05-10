import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/projet/state/projet_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjetPublicList extends ConsumerStatefulWidget {
  const ProjetPublicList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjetPublicListState();
}

class _ProjetPublicListState extends ConsumerState<ProjetPublicList> {
  @override
  Widget build(BuildContext context) {
    final projets = ref.watch(projetsOfProfilStream);

    return Container(
      child: projets.when(
        data: (projets) {
          return Wrap(
            spacing: 150.0,
            children: projets.map((projet) {
              return Container(
                margin: const EdgeInsets.only(top: 50.0),
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// image
                    displayImage(urlE: projet.image, height: 150),

                    /// title
                    Container(
                      margin: const EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        projet.title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),

                    /// text
                    Text(
                      projet.descriptif,
                      textAlign: TextAlign.justify,
                    ),

                    /// list techno projet
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Technos utilisées :',
                              textAlign: TextAlign.left,
                              style: const TextStyle().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              projet.techno,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// lien du site
                    BtnText(
                      text: projet.title,
                      message: 'Visiter le site',
                      onPressed: () {
                        launchUrl(Uri.parse(projet.lien));
                      },
                      icon: Icons.launch_rounded,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
        error: (error, stack) => WaitingError(
          messageError: 'Impossible de recuperer les projets',
        ),
        loading: () => WaitingLoad(),
      ),
    );
  }
}
