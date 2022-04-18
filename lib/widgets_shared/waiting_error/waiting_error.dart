

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/utils/const/text_error.dart';

class WaitingError extends ConsumerWidget {
  String messageError;

  WaitingError({
    Key? key,
    required this.messageError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _height = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        height: _height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// title
            Container(
              margin: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                TextError.titleWidgetWaitingError,
                style: const TextStyle().copyWith(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),

            /// message d'error
            Text(
              messageError,
              textAlign: TextAlign.center,
              style: const TextStyle().copyWith(
                fontSize: 22.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
