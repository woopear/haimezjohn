import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/contact/presentation/public/contact_form.dart';
import 'package:haimezjohn/src/models/contact/state/contact_provider.dart';
import 'package:haimezjohn/src/models_shared/info_perso/presentation/public/info_perso_public_widget.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

class ContactPublicWidget extends ConsumerStatefulWidget {
  const ContactPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactPublicWidgetState();
}

class _ContactPublicWidgetState extends ConsumerState<ContactPublicWidget> {
  @override
  Widget build(BuildContext context) {
    return layoutPartialPublic(
      context: context,
      child: ref.watch(contactFuture).when(
            data: (contact) {
              return Column(
                children: [
                  /// title + text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: Responsive.isDesktop(context)
                            ? null
                            : const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          contact.title,
                          style: GoogleFonts.openSans(
                            fontSize: Responsive.isDesktop(context) ? 56 : 38,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      /// text
                      Container(
                        alignment: Alignment.topLeft,
                        margin: Responsive.isDesktop(context)
                            ? null
                            : const EdgeInsets.symmetric(horizontal: 30),
                        width: 600,
                        child: Html(
                          data: contact.subTitle,
                          style: {
                            '*': Style(
                              fontSize: Responsive.isDesktop(context)
                                  ? FontSize.xxLarge
                                  : FontSize.xLarge,
                            )
                          },
                        ),
                      ),
                    ],
                  ),

                  /// information perso
                  Container(
                    margin: EdgeInsets.only(left: Responsive.isMobile(context) || Responsive.isTablet(context) ? 30 : 0, top: 50, bottom: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Coordonnées',
                      style: GoogleFonts.openSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const InfoPersoPublicWidget(),

                  /// contact formulaire
                  const ContactForm(),
                ],
              );
            },
            error: (error, stack) => WaitingError(
              messageError: 'Impossible de recuperer les infos',
            ),
            loading: () => WaitingLoad(),
          ),
    );
  }
}
