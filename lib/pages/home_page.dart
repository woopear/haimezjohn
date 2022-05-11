import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/layout_page_public/layout_page_public.dart';
import 'package:haimezjohn/src/models/competence/presentation/public/competence_public_widget.dart';
import 'package:haimezjohn/src/models/contact/presentation/public/contact_public_widget.dart';
import 'package:haimezjohn/src/models/portfolio/presentation/public/portfolio_public_widget.dart';
import 'package:haimezjohn/src/models/profil/presentation/public/profil_public_widget.dart';
import 'package:haimezjohn/src/models/setting/state/setting_provider.dart';
import 'package:haimezjohn/pages/error_page.dart';
import 'package:haimezjohn/pages/loading_page.dart';
import 'package:haimezjohn/src/utils/const/text_error.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return ref.watch(settingsStream).when(
          data: (settings) {
            /* build
            if (settings[0].build) {
              return BuildPage(textInfo: Globals.textInfoPageBuild,);
            }*/

            /// page home
            return layoutPagePublic(
              context: context,
              child: Column(
                children: const [
                  /// a propos
                  ProfilPublicWidget(),
                  
                  /// competence
                  CompetencePublicWidget(),

                  /// portfolio
                  PortfolioPublicWidget(), 
                  
                  /// contact
                  ContactPublicWidget(),
                  
                  /// footer
                ],
              ),
            );
          },
          error: (error, stack) => ErrorPage(
            messageError: TextError.errorDataPageHome,
          ),
          loading: () => const LoadingPage(),
        );
  }
}
