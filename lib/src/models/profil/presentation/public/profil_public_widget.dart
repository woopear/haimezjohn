import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_partial_public/layout_partial_public.dart';
import 'package:haimezjohn/src/components/title_cat_public/title_cat_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/link/presentation/public/link_public_widget.dart';
import 'package:haimezjohn/src/models/link/presentation/public/link_title.dart';
import 'package:haimezjohn/src/models/link/state/link_provider.dart';
import 'package:haimezjohn/src/models/profil/presentation/public/profil_image_text.dart';
import 'package:haimezjohn/src/models/profil/state/profil_provider.dart';

class ProfilPublicWidget extends ConsumerStatefulWidget {
  const ProfilPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilPublicWidgetState();
}

class _ProfilPublicWidgetState extends ConsumerState<ProfilPublicWidget> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le profil
    final profil = ref.watch(profilProvider);

    return layoutPartialPublic(
      context: context,
      child: profil != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// title
                titleCatPublic(
                  context: context,
                  title: profil.title,
                  subTitle: 'DE MOI',
                ),

                /// image + text en mode pc
                profilImageText(
                  context: context,
                  profil: profil,
                ),

                /// todo link réseau en mode pc assez gros
                /// todo en mode mobile plus petit

                /// title de la partie link
                linkTitle(context: context),

                /// links
                ref.watch(linkAllStream).when(
                      data: (links) {
                        return Container(
                          margin: const EdgeInsets.only(top: 80),
                          height: 120,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: links.length,
                            itemBuilder: ((context, index) {
                              if (links[index] == null) {
                                return Container();
                              }
                              return linkPublicWidget(
                                links[index]!,
                                finishTab: links.length == index,
                                onPressed: () {},
                              );
                            }),
                          ),
                        );
                      },
                      error: (error, stack) => WaitingError(
                        messageError: 'Impossible de récuperer les liens',
                      ),
                      loading: () => WaitingLoad(),
                    ),
              ],
            )
          : WaitingLoad(),
    );
  }
}
