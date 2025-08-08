import 'package:flutter/material.dart';

class BreathingWidget extends StatefulWidget {
  const BreathingWidget({
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.minScale = 0.8,
    this.maxScale = 1.2,
    this.curve = Curves.easeInOut,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  final Curve curve;

  @override
  BreathingWidgetState createState() => BreathingWidgetState();
}

class BreathingWidgetState extends State<BreathingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
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
