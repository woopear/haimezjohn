import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_content_private/layout_content_private.dart';
import 'package:haimezjohn/src/components/layout_page_private/layout_page_private.dart';
import 'package:haimezjohn/src/models/contact/presentation/private/contact_form.dart';

class ContactPagePrivate extends ConsumerStatefulWidget {
  const ContactPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactPagePrivateState();
}

class _ContactPagePrivateState extends ConsumerState<ContactPagePrivate> {
  @override
  Widget build(BuildContext context) {
    return layoutPagePrivate(
      child: layoutContentPrivate(
        children: [
          /// formulaire contact update
          const ContactForm(),
        ],
      ),
    );
  }
}
