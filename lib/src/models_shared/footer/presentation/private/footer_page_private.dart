import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models_shared/footer/presentation/private/footer_form.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';

class FooterPagePrivate extends ConsumerStatefulWidget {
  const FooterPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FooterPagePrivateState();
}

class _FooterPagePrivateState extends ConsumerState<FooterPagePrivate> {
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
          /// title
          titlePageAdmin(text: 'Le footer', context: context),

          /// formulaire
          const FooterForm(),
        ],
      ),
    );
  }
}
