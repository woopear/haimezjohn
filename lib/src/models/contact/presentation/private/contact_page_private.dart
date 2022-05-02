import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
            child: Column(
              children: const [
                /// formulaire contact update
                ContactForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
