import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/projet/state/projet_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjetPublicList extends ConsumerStatefulWidget {
  const ProjetPublicList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjetPublicListState();
}

class _ProjetPublicListState extends ConsumerState<ProjetPublicList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ref.watch(projetAllFuture).when(
            data: (projets) {
              return Column(
                children: [
                  /// list des projets
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context)
                            ? 2
                            : Responsive.isTablet(context)
                                ? 2
                                : 1,
                        childAspectRatio: Responsive.isMobile(context)
                            ? 1 / 1.5
                            : Responsive.isTablet(context)
                                ? 1 / 1.2
                                : 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 40,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: projets.length,
                      itemBuilder: (context, index) {
                        final projet = projets[index];
                        return Container(
                          margin: const EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  Responsive.isDesktop(context) ? 20 : 0),
                            ),
                          ),
                          child: GridTile(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(
                                children: [
                                  /// title
                                  Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      projet.title,
                                      style: GoogleFonts.openSans(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),

                                  /// text
                                  Expanded(
                                    child: Html(data: projet.descriptif),
                                  ),

                                  /// btn links
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        /// link
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            launchUrlString(projet.lien);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.link,
                                            size: 14,
                                          ),
                                          label: Text(
                                            'Voir le site',
                                            style: GoogleFonts.openSans(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),

                                        /// link github
                                        projet.lienGithub != ''
                                        ? Container(
                                          margin: const EdgeInsets.only(left: 20.0),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              launchUrlString(projet.lienGithub);
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.link,
                                              size: 14,
                                            ),
                                            label: Text(
                                              'GitHub',
                                              style: GoogleFonts.openSans(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                        : Container(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
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
