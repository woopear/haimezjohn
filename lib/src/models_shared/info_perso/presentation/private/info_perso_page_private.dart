import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  titlePageAdmin(text: 'Infos Perso', context: context),

                  /// formulaire
                  const InfoPersoForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
