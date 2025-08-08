import 'package:flutter/material.dart';

class TabletConstraintBox extends StatelessWidget {
  const TabletConstraintBox({
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.spacing = 16,
    super.key,
  });

  final List<Widget> children;
  final double spacing;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

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
