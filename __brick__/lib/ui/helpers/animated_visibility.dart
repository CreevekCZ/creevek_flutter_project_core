import 'package:flutter/widgets.dart';

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.height,
    this.width,
    this.invisibleHeight = 0,
    this.invisibleWidth = 0,
    super.key,
  });

  final Duration duration;
  final Widget child;
  final bool visible;

  final Curve curve;

  final double? height;
  final double? width;

  final double invisibleHeight;
  final double invisibleWidth;

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
