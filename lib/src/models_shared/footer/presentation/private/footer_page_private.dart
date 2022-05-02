import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';

class FooterPagePrivate extends ConsumerStatefulWidget {
  const FooterPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterPagePrivateState();
}

class _FooterPagePrivateState extends ConsumerState<FooterPagePrivate> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
              child: Column(
                children: [
                  /// title
                  titlePageAdmin(text: 'Le footer', context: context),

                  /// formulaire
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}