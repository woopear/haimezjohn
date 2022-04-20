import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';
import 'package:haimezjohn/src/models/profil/presentation/private/profil_update_form.dart';
import 'package:haimezjohn/src/models/profil/schema/profil_schema.dart';
import 'package:haimezjohn/src/models/profil/state/profil_provider.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_provider.dart';
import 'package:haimezjohn/src/utils/const/globals.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';

class ProfilPagePrivate extends ConsumerStatefulWidget {
  const ProfilPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilPagePrivateState();
}

class _ProfilPagePrivateState extends ConsumerState<ProfilPagePrivate> {
  /// suppression image
  Future<void> _deleteImageDirectly(ProfilSchema oldProfil) async {
    try {
      /// supprimer proprieter image
      final newProfil = oldProfil;
      newProfil.image = '';
      await ref.watch(profilChange).updateProfil(oldProfil.id!, newProfil);

      /// suppression de l'image dans storage
      await ref
          .watch(uploadFileChange)
          .deleteImage(Globals.adresseStorageProfil);

      /// notif succes
      Notif(
        text: Globals.messageSuccesImageDelProfil,
        error: false,
      ).notification(context);
    } catch (e) {
      /// notif error
      Notif(
        text: Globals.messageErrorImageProfil,
        error: true,
      ).notification(context);
    }
  }

  /// suppression profil
  Future<void> _deleteProfil(ProfilSchema oldProfil) async {
    try {
      /// supprimer image
      await _deleteImageDirectly(oldProfil);

      /// supprimer profil
      await ref.watch(profilChange).deleteProfil(oldProfil.id!);

      /// notif succes
      Notif(
        text: Globals.messageSuccesDelProfil,
        error: false,
      ).notification(context);
    } catch (e) {
      /// notif error
      Notif(
        text: Globals.messageErrorDelProfil,
        error: false,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              /// title + btn delete
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// title page
                                  titlePageAdmin(
                                    text: Globals.titlePageProfilPrivateUpdate,
                                    context: context,
                                  ),

                                  /// btn delete
                                  btnDeleteOne(
                                    onPressed: () async {
                                      await _deleteProfil(profils[0]);
                                    },
                                    message: Globals.tooltipMessageDeleteProfil,
                                  )
                                ],
                              ),

                              /// update profil
                              ProfilUpdateForm(),
                            ],
                          )

                        /// creation du profil
                        : Center(
                            child: SizedBox(
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
                                  ProfilUpdateForm(created: true),
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
