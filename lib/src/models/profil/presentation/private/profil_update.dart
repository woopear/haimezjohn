import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';

class ProfilUpdate extends ConsumerStatefulWidget {
  bool created;

  ProfilUpdate({
    Key? key,
    this.created = false,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends ConsumerState<ProfilUpdate> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width > 700 ? 600 : double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Form(
        child: Column(
          children: [
            /// input image

            /// title
            inputBasic(
              labelText: 'Titre du profil',
            ),

            /// text
            inputBasic(
              hintText: 'Votre description',
              maxLines: 7,
            ),

            /// btn save
            btnElevated(
              onPressed: () {},
              text: widget.created ? 'Créer' : 'Modifier',
            ),
          ],
        ),
      ),
    );
  }
}
