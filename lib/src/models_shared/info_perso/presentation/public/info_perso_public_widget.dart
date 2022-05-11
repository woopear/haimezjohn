import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_text/btn_text.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models_shared/info_perso/state/info_perso_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPersoPublicWidget extends ConsumerStatefulWidget {
  const InfoPersoPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfoPersoPublicWidgetState();
}

class _InfoPersoPublicWidgetState extends ConsumerState<InfoPersoPublicWidget> {
  @override
  Widget build(BuildContext context) {
    return layoutPartialPublic(
      context: context,
      child: ref.watch(infoPersoOneStream).when(
            data: (infoPerso) {
              String? adresse;
              if (infoPerso != null) {
                adresse =
                    '${infoPerso.address}, ${infoPerso.codePost} ${infoPerso.city}';
              }
              return Container(
                child: Responsive.isDesktop(context)
                    ? Row(
                        children: [
                          /// address
                          Expanded(
                            flex: 1,
                            child: BtnText(
                              text: 'Voir mon adresse',
                              message: 'Voir mon adresse',
                              icon: Icons.launch_rounded,
                              onPressed: () {
                                MapsLauncher.launchQuery(adresse!);
                              },
                            ),
                          ),

                          /// espace séparation
                          const SizedBox(
                            width: 150,
                          ),

                          /// phone
                          Expanded(
                            flex: 1,
                            child: BtnText(
                              text: 'Appellez moi directement',
                              message: 'Appeller John Haimez',
                              icon: Icons.launch_rounded,
                              onPressed: () {
                                launchUrlString('tel://${infoPerso!.phone}');
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          /// adresse
                          BtnText(
                            text: 'Voir mon adresse',
                            message: 'Voir mon adresse',
                            icon: Icons.launch_rounded,
                            onPressed: () {
                              MapsLauncher.launchQuery(adresse!);
                            },
                          ),

                          /// phone
                          BtnText(
                            text: 'Appellez moi directement',
                            message: 'Appeller John Haimez',
                            icon: Icons.launch_rounded,
                            onPressed: () {
                              launchUrlString('tel://${infoPerso!.phone}');
                            },
                          ),
                        ],
                      ),
              );
            },
            error: (error, stack) => WaitingError(
              messageError: 'Impossible de récuperer les infos perso',
            ),
            loading: () => WaitingLoad(),
          ),
    );
  }
}
