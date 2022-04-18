import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/models/setting/state/setting_provider.dart';
import 'package:haimezjohn/pages/build_page.dart';
import 'package:haimezjohn/pages/error_page.dart';
import 'package:haimezjohn/pages/loading_page.dart';
import 'package:haimezjohn/utils/const/globals.dart';
import 'package:haimezjohn/utils/const/text_error.dart';

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
            /// build
            if (settings[0].build) {
              return BuildPage(textInfo: Globals.textInfoPageBuild,);
            }

            /// page home
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: _width,
                    height: _height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        
                      ],
                    ),
                  ),
                ),
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