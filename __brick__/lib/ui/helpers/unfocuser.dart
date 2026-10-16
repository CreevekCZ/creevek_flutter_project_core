import 'package:flutter/material.dart';

class const Unfocuser({
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => primaryFocus?.unfocus(),
    child: child,
  );
}
