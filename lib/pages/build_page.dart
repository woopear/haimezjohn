import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/utils/config/theme/colors.dart';

class BuildPage extends ConsumerWidget {
  String textInfo;

  BuildPage({Key? key, required this.textInfo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// icon
                Icon(
                  Icons.build_circle_rounded,
                  size: 100,
                  color: ColorCustom().greenLight,
                ),

                /// text info
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    textInfo,
                    style: const TextStyle().copyWith(fontSize: 28.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}