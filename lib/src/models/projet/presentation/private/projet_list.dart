import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/portfolio/state/portfolio_provider.dart';
import 'package:haimezjohn/src/models/projet/schema/projet_schema.dart';
import 'package:haimezjohn/src/models/projet/state/projet_provider.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_list_title.dart';

class ProjetList extends ConsumerStatefulWidget {
  const ProjetList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjetListState();
}

class _ProjetListState extends ConsumerState<ProjetList> {
  /// creation projet vierge
  Future<void> _createProjet(String idPortfolio) async {
    final newProjet = ProjetSchema(
      descriptif: '',
      image: '',
      lien: '',
      techno: '',
      title: 'Aucun titre',
    );
    await ref.watch(projetChange).addProjet(
          idPortfolio,
          newProjet,
        );

    Notif(
      text: 'Projet vierge créer',
      error: false,
    ).notification(context);
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    /// on recupere le portfolio en cours
    final portfolioProgress = ref.watch(portfolioProgressProvider);

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      margin: const EdgeInsets.only(bottom: 60.0),
      child: Column(
        children: [
          /// creation projet
          BtnText(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 60.0),
              icon: Icons.add_circle_outline_rounded,
              message: 'Ajouter un projet',
              text: 'Créer un projet',
              onPressed: () async {
                await _createProjet(
                  portfolioProgress!.id!,
                );
              }),

          /// list des projets
          ref.watch(projetsOfProfilStream).when(
                data: (projets) {
                  /// si pas de projets affiche message
                  if (projets.isEmpty) {
                    return Container(
                      child: const Text('Aucun projet !'),
                    );
                  }

                  /// si il y a des projets on les affiches
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: projets.length,
                    itemBuilder: (context, index) {
                      final projet = projets[index];

                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            /// title techno
                            Expanded(
                              child: titleListTechno(text: projet.title),
                            ),

                            /// todo btn action
                            
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => WaitingError(
                  messageError: 'Impossible de récuperer les projets',
                ),
                loading: () => WaitingLoad(),
              ),
        ],
      ),
    );
  }
}
