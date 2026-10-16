import 'package:flutter/material.dart';

class const Disabled({
  required final Widget child,
  required final bool disabled,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: child,
    );
  }
}
