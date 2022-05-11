import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/components/input_basic/input_basic.dart';

class InputPassword extends ConsumerStatefulWidget {
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 20.0);
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0);
  late String labelText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  late TextEditingController controller;

  InputPassword({
    Key? key,
    this.margin = const EdgeInsets.only(top: 20.0),
    this.padding = const EdgeInsets.all(0.0),
    required this.labelText,
    this.onChanged,
    this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputPasswordState();
}

class _InputPasswordState extends ConsumerState<InputPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return inputBasic(
        controller: widget.controller,
        margin: widget.margin,
        padding: widget.padding,
        labelText: widget.labelText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        obscureText: _obscureText,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: _obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ));
  }
}
