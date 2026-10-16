import 'package:flutter/material.dart';

class const TabletConstraintBox({
  required final List<Widget> children,
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  final double spacing = 16,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        spacing: spacing,
        children: children,
      ),
    );
  }
}
