import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_primary_partial_public/layout_primary_partial_public.dart';
import 'package:haimezjohn/src/components/waiting_error/waiting_error.dart';
import 'package:haimezjohn/src/components/waiting_load/waiting_load.dart';
import 'package:haimezjohn/src/models/link/presentation/public/link_public_widget.dart';
import 'package:haimezjohn/src/models/link/state/link_provider.dart';
import 'package:haimezjohn/src/models/profil/presentation/public/profil_image_text.dart';
import 'package:haimezjohn/src/models/profil/state/profil_provider.dart';
import 'package:haimezjohn/src/utils/config/theme/responsive.dart';

class ProfilPublicWidget extends ConsumerStatefulWidget {
  const ProfilPublicWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilPublicWidgetState();
}

class _ProfilPublicWidgetState extends ConsumerState<ProfilPublicWidget> {
  @override
  Widget build(BuildContext context) {

    return layoutPrimaryPartialPublic(
      context: context,
      child: ref.watch(profilFuture).when(
        data: (profil) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// image + text en mode pc
              profilImageText(
                context: context,
                profil: profil,
              ),

              /// links
              ref.watch(linkAllStream).when(
                    data: (links) {
                      return Container(
                        margin: EdgeInsets.only(top: Responsive.isDesktop(context) ? 80 : 50, bottom: 80),
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
                              context: context,
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
          );
        },
        error: (error, stack) => WaitingError(
          messageError: 'Impossible de récuperer le profil',
        ),
        loading: () => WaitingLoad(),
      ),
    );
  }
}
