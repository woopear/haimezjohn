import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_list_title.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/tecno_list_btn_action.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';

class TechnoList extends ConsumerStatefulWidget {
  const TechnoList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TechnoListState();
}

class _TechnoListState extends ConsumerState<TechnoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      margin: const EdgeInsets.only(
          top: 40.0, bottom: 50.0, left: 30.0, right: 30.0),
      child: Column(
        children: [
          ref.watch(t).when(
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
                            /// todo faire les action et l'affichage de la techno selectionné
                            btnActionListTechno(
                              onPressedDelete: () {},
                              onPressedUpdate: () {},
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
