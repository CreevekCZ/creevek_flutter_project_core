import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    this.isLoading = false,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
