import 'package:flutter/material.dart';

class Unfocuser extends StatelessWidget {
  const Unfocuser({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => primaryFocus?.unfocus(),
    child: child,
  );
}
