import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/techno/presentation/public/techno_item.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';

class TechnoPublicList extends ConsumerStatefulWidget {
  const TechnoPublicList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TechnoPublicListState();
}

class _TechnoPublicListState extends ConsumerState<TechnoPublicList> {
  @override
  Widget build(BuildContext context) {
    /// on recupere les technos
    final technos = ref.watch(technosStream);

    /// list des technos
    return technos.when(
      data: (technos) {
        return Wrap(
          spacing: 100.0,
            children: technos.map((techno) {
          return technoItem(techno: techno);
        }).toList());
      },
      error: (error, stack) =>
          WaitingError(messageError: 'Impossible de récuperer les technos'),
      loading: () => WaitingLoad(),
    );
  }
}
