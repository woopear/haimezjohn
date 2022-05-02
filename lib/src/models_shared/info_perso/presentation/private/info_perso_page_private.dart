import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoPersoPagePrivate extends ConsumerStatefulWidget {
  const InfoPersoPagePrivate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoPersoPagePrivateState();
}

class _InfoPersoPagePrivateState extends ConsumerState<InfoPersoPagePrivate> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
            child: Column(
              children: const [
              ],
            ),
          ),
        ),
      ),
    );
  }
}