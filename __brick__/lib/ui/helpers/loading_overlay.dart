import 'package:flutter/material.dart';

class const LoadingOverlay({
  required final Widget child,
  final bool isLoading = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
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
