import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/contact/presentation/public/contact_form.dart';
import 'package:haimezjohn/src/models/contact/presentation/public/contact_title.dart';
import 'package:haimezjohn/src/models/contact/state/contact_provider.dart';
import 'package:haimezjohn/src/models_shared/info_perso/presentation/public/info_perso_public_widget.dart';

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
      child: ref.watch(contactStream).when(
            data: (contact) {
              return Column(
                children: [
                  /// title + sub title
                  titleCatPublic(
                    title: contact!.title,
                    subTitle: contact.subTitle,
                    oneOnOne: true,
                    context: context,
                  ),

                  /// contact formulaire
                  const ContactForm(),

                  /// title info perso
                  contactTitle(context: context),

                  /// information perso
                  const InfoPersoPublicWidget()
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
