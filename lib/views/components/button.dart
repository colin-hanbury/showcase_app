import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final Function() onPressed;

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return !kIsWeb && (Platform.isIOS || Platform.isMacOS)
        ? CupertinoButton(
            onPressed: widget.onPressed,
            child: widget.child,
          )
        : MaterialButton(
            onPressed: widget.onPressed,
            child: widget.child,
          );
  }
}
