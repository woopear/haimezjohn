import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_list_title.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/tecno_list_btn_action.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';

class TechnoList extends ConsumerStatefulWidget {
  const TechnoList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechnoListState();
}

class _TechnoListState extends ConsumerState<TechnoList> {
  Future<void> deleteTechno(String idCompetence, String idTechno) async {
    /// todo delete image avant delete techno

    /// delete
    await ref.watch(technoChange).deleteTechno(idCompetence, idTechno);
  }

  @override
  Widget build(BuildContext context) {
    final competenceProgress = ref.watch(competencesProvider);

    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      margin: const EdgeInsets.only(
          top: 0.0, bottom: 50.0, left: 30.0, right: 30.0),
      child: Column(
        children: [
          ref.watch(technosStream).when(
                data: (technos) {
                  /// si pas de techno affiche message
                  if (technos.isEmpty) {
                    return Container(
                      child: const Text('Aucune technos'),
                    );
                  }

                  /// si il y a des technos on affiche la liste
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: technos.length,
                    itemBuilder: (context, index) {
                      final techno = technos[index];

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
                              child: titleListTechno(text: techno.title),
                            ),

                            /// btn action
                            btnActionListTechno(
                              onPressedDelete: () async {
                                await deleteTechno(
                                    competenceProgress!.id!, techno.id!);
                              },
                              onPressedUpdate: () {
                                /// on recupere toute la techno selectionné
                                ref.watch(technoChange).streamTechno(
                                    competenceProgress!.id!, techno.id!);
                                /// on recupere l'id de la competence concerné
                                ref
                                    .watch(competenceChange)
                                    .getIdCompetence(competenceProgress.id!);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) =>
                    WaitingError(messageError: "Une erreur est survenu"),
                loading: () => WaitingLoad(),
              ),
        ],
      ),
    );
  }
}
