import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                /// title page
                titlePageAdmin(text: 'Compétence', context: context),

                /// form competence
                const CompetenceForm(),

                /// btn ajoute techno
                BtnText(
                  text: 'Ajouter une techno',
                  onPressed: () {},
                  icon: Icons.add_circle_outline_rounded,
                  message: 'ajouter une techno',
                ),

                /// liste techo
                /// todo faire list techno
                const TechnoList(),

                /// form techno
                const TechnoForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
