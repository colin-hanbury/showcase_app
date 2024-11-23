import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final bool mode;
  final ValueChanged<bool>? onChanged;

  @override
  State<StatefulWidget> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return !kIsWeb && (Platform.isIOS || Platform.isMacOS)
        ? CupertinoSwitch(
            value: widget.mode,
            onChanged: widget.onChanged,
          )
        : Switch(
            value: widget.mode,
            onChanged: widget.onChanged,
          );
  }
}
