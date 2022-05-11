import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models/competence/presentation/private/competence_form.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_form.dart';
import 'package:haimezjohn/src/models/techno/presentation/private/techno_list.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';

class CompetencePagePrivate extends ConsumerStatefulWidget {
  const CompetencePagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompetencePagePrivateState();
}

class _CompetencePagePrivateState extends ConsumerState<CompetencePagePrivate> {

  @override
  void initState() {
    super.initState();

    /// si deconnecter retour sur la page app (connexion ou dashboard)
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, Routes().home);
          }));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return layoutPagePrivate(
      context: context,
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
