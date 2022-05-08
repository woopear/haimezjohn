import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models/competence/presentation/private/competence_form.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_form.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_list.dart';

class CompetencePagePrivate extends ConsumerStatefulWidget {
  const CompetencePagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompetencePagePrivateState();
}

class _CompetencePagePrivateState extends ConsumerState<CompetencePagePrivate> {
  @override
  Widget build(BuildContext context) {
    return layoutPagePrivate(
      child: layoutContentPrivate(
        children: [
          /// title page
          titlePageAdmin(text: 'Compétence', context: context),

          /// form competence
          const CompetenceForm(),

          /// liste techo
          const TechnoList(),

          /// form techno
          const TechnoForm(),
        ],
      ),
    );
  }
}
