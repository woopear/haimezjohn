import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnText extends ConsumerStatefulWidget {
  IconData? icon;
  String? message;
  String text;
  void Function()? onPressed;
  EdgeInsetsGeometry margin;
  AlignmentGeometry alignment;
  EdgeInsetsGeometry? padding;
  double? fontSize;

  BtnText({
    Key? key,
    this.icon,
    this.message,
    required this.text,
    required this.onPressed,
    this.margin = const EdgeInsets.symmetric(vertical: 20.0),
    this.alignment = Alignment.center,
    this.padding,
    this.fontSize,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BtnTextState();
}

class _BtnTextState extends ConsumerState<BtnText> {
  bool underline = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        child: Tooltip(
          message: widget.message,
          child: widget.icon != null

              /// btn avec icon
              ? TextButton.icon(
                  onHover: (value) {
                    setState(() {
                      underline = value;
                    });
                  },
                  onPressed: widget.onPressed,
                  icon: Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  label: Text(
                    widget.text,
                    style: const TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: widget.fontSize,
                      decoration: underline ? TextDecoration.underline : null,
                    ),
                  ),
                )

              /// btn sans icon
              : TextButton(
                  onHover: (value) {
                    setState(() {
                      underline = value;
                    });
                  },
                  onPressed: widget.onPressed,
                  child: Text(
                    widget.text,
                    style: const TextStyle().copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: widget.fontSize,
                      decoration: underline ? TextDecoration.underline : null,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
