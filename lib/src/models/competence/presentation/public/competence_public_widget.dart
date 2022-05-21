import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/competence/state/competence_provider.dart';
import 'package:haimezjohn/src/models/techno/presentation/public/techno_public_list.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CompetencePublicWidget extends ConsumerStatefulWidget {
  const CompetencePublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompetencePublicWidgetState();
}

class _CompetencePublicWidgetState
    extends ConsumerState<CompetencePublicWidget> {
  @override
  Widget build(BuildContext context) {
    return layoutPartialPublic(
      context: context,
      child: ref.watch(competenceFuture).when(
            data: (competence) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// title
                  Container(
                    margin: Responsive.isDesktop(context) 
                    ? null 
                    : const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      competence.title,
                      style: GoogleFonts.openSans(
                        fontSize: Responsive.isDesktop(context) ? 56 : 38,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  /// text
                  Container(
                     margin: Responsive.isDesktop(context) 
                    ? null 
                    : const EdgeInsets.symmetric(horizontal: 30),
                    width: 600,
                    child: Html(
                      data: competence.subTitle,
                      style: {
                        '*': Style(
                          fontSize: Responsive.isDesktop(context)
                              ? FontSize.xxLarge
                              : FontSize.xLarge,
                        )
                      },
                    ),
                  ),

                  /// list techno
                  const TechnoPublicList(),

                  Container(
                    child: Column(
                      children: [

                        /// btn telecharger cv
                        btnElevated(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 90),
                          onPressed: () {
                            launchUrlString('https://8oj0p722.directus.app/assets/${competence.cvPdf}');
                          },
                          text: 'Télécharger mon cv',
                        ),

                        /// image CV
                        displayImage(
                          margin: const EdgeInsets.only(top: 40.0),
                          height: Responsive.isDesktop(context) ? 700 : 450,
                          urlE: 'https://8oj0p722.directus.app/assets/${competence.image}',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) => WaitingError(
              messageError: 'Impossible de récuperer la partie compétence',
            ),
            loading: () => WaitingLoad(),
          ),
    );
  }
}
