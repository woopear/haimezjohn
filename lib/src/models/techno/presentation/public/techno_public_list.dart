import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/techno/presentation/public/techno_item.dart';
import 'package:haimezjohn/src/models/techno/schema/techno_schema.dart';
import 'package:haimezjohn/src/models/techno/state/techno_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

class TechnoPublicList extends ConsumerStatefulWidget {
  const TechnoPublicList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TechnoPublicListState();
}

class _TechnoPublicListState extends ConsumerState<TechnoPublicList> {
  @override
  Widget build(BuildContext context) {
    final technos = ref.watch(technoAllFuture);

    /// list des technos
    return technos.when(
      data: (technos) {
        /// list hard
        final List<TechnoSchema?> technosHard = [];
        for (var element in technos) {
          if (element!.type == "hs") {
            technosHard.add(element);
          }
        }

        final List<TechnoSchema?> technosSoft = [];
        for (var element in technos) {
          if (element!.type == "ss") {
            technosSoft.add(element);
          }
        }

        return Column(
          children: [
            /// hard
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Hard skills',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context) ? 3 : 1,
                mainAxisExtent: 500,
                mainAxisSpacing: 20,
                crossAxisSpacing: 40,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: technosHard.length,
              itemBuilder: (context, index) {
                final techno = technosHard[index];
                return technoItem(
                  context: context,
                  techno: techno!,
                );
              },
            ),

            /// soft
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Soft skills',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context) ? 3 : 1,
                mainAxisExtent: 500,
                mainAxisSpacing: 20,
                crossAxisSpacing: 40,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: technosSoft.length,
              itemBuilder: (context, index) {
                if (technosSoft[index] == null) {
                  return Container();
                }

                final techno = technosSoft[index];
                return technoItem(
                  context: context,
                  techno: techno!,
                );
              },
            ),
          ],
        );
      },
      error: (error, stack) =>
          WaitingError(messageError: 'Impossible de récuperer les technos'),
      loading: () => WaitingLoad(),
    );
  }
}
