import 'package:flutter/material.dart';

class const BreathingWidget({
  required final Widget child,
  final Duration duration = const Duration(seconds: 2),
  final double minScale = 0.8,
  final double maxScale = 1.2,
  final Curve curve = Curves.easeInOut,
  super.key,
}) extends StatefulWidget {
  @override
  BreathingWidgetState createState() => BreathingWidgetState();
}

class BreathingWidgetState extends State<BreathingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
    _scaleAnimation =
        Tween<double>(
          begin: widget.minScale,
          end: widget.maxScale,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
