import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haimezjohn/src/utils/config/theme/colors.dart';

class WaitingLoad extends ConsumerWidget {
  double size;

  WaitingLoad({
    Key? key,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        width: _width,
        height: _height,
        child: SpinKitCircle(
          color: ColorCustom().greenMedium,
          size: size,
        ),
      ),
    );
  }
}
