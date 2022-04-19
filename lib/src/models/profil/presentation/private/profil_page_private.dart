import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/components/title_page_admin/title_page_admin.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_update.dart';
import 'package:haimezjohn/src/models/profil/state/profil_provider.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';

class ProfilPagePrivate extends ConsumerStatefulWidget {
  const ProfilPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilPagePrivateState();
}

class _ProfilPagePrivateState extends ConsumerState<ProfilPagePrivate> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: ref.watch(profilsStream).when(
                  data: (profils) {
                    return profils.isNotEmpty

                        /// affichage du profil
                        ? Column(
                            children: [
                              /// title page
                              titlePageAdmin(
                                text: Globals.titlePageProfilPrivateUpdate,
                                context: context,
                              ),

                              /// update profil
                              ProfilUpdate(),
                            ],
                          )

                        /// creation du profil
                        : Center(
                            child: SizedBox(
                              width: _width,
                              height: _height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// title page creer profil
                                  titlePageAdmin(
                                    text: Globals.titlePageProfilPrivateCreate,
                                    context: context,
                                  ),

                                  /// creer profil
                                  ProfilUpdate(created: true),
                                ],
                              ),
                            ),
                          );
                  },
                  error: (error, stack) => WaitingError(
                      messageError: TextError.errorDataPageProfilPrivate),
                  loading: () => WaitingLoad(),
                ),
          ),
        ),
      ),
    );
  }
}
