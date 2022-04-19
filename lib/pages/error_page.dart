import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/index.dart';

class ErrorPage extends ConsumerWidget {
  String messageError;
  ErrorPage({Key? key, required this.messageError}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body:  WaitingError(messageError: messageError),
      ),
    );
  }
}
