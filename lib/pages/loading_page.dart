import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/utils/config/theme/colors.dart';
import 'package:haimezjohn/components/index.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorCustom().fondDark,
        body: WaitingLoad(),
      ),
    );
  }
}
