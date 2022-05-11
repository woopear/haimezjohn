import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/models/contact/presentation/private/contact_form.dart';
import 'package:haimezjohn/src/utils/config/routes/routes.dart';

class ContactPagePrivate extends ConsumerStatefulWidget {
  const ContactPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactPagePrivateState();
}

class _ContactPagePrivateState extends ConsumerState<ContactPagePrivate> {
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
          /// formulaire contact update
          const ContactForm(),
        ],
      ),
    );
  }
}
