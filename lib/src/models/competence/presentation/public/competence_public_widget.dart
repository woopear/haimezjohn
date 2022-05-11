import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/btn_elevated/btn_elevated.dart';
import 'package:haimezjohn/src/components/display_image_form/display_image_form.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/competence/presentation/public/competence_title_cv.dart';
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
    /// on recupere la competence
    final competence = ref.watch(competencesProvider);

    return layoutPartialPublic(
      context: context,
      child: competence != null
          ? Column(
              children: [
                /// title + sub
                titleCatPublic(
                    title: competence.title,
                    subTitle: competence.subTitle,
                    oneOnOne: true,
                    context: context,
                    margin: const EdgeInsets.only(bottom: 70.0)),

                /// list techno
                const TechnoPublicList(),

                Container(
                  child: Column(
                    children: [
                      /// title
                      competenceTitleCv(context: context),

                      /// btn telecharger cv
                      btnElevated(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 90),
                        onPressed: () {
                          launchUrlString(competence.cvPdf);
                        },
                        text: 'Version pdf',
                      ),

                      /// image CV
                      displayImage(
                        margin: const EdgeInsets.only(top: 40.0),
                        height: Responsive.isDesktop(context) ? 700 : 450,
                        urlE: competence.image,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : WaitingLoad(),
    );
  }
}
