import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models_shared/info_perso/presentation/private/info_perso_form.dart';

class InfoPersoPagePrivate extends ConsumerStatefulWidget {
  const InfoPersoPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfoPersoPagePrivateState();
}

class _InfoPersoPagePrivateState extends ConsumerState<InfoPersoPagePrivate> {
  @override
  Widget build(BuildContext context) {
    return layoutPagePrivate(
      context: context,
      child: layoutContentPrivate(
        children: [
          /// title
          titlePageAdmin(text: 'Infos Perso', context: context),

          /// formulaire
          const InfoPersoForm(),
        ],
      ),
    );
  }
}
