import 'package:flutter/widgets.dart';

class const AnimatedVisibility({
  required final Widget child,
  required final bool visible,
  final Duration duration = const Duration(milliseconds: 300),
  final Curve curve = Curves.easeInOut,
  final double? height,
  final double? width,
  final double invisibleHeight = 0,
  final double invisibleWidth = 0,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: duration,
    curve: curve,
    child: SizedBox(
      height: visible ? height : invisibleHeight,
      width: visible ? width : invisibleWidth,
      child: Visibility(
        visible: visible,
        child: child,
      ),
    ),
  );
}
