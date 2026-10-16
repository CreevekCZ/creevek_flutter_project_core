import 'package:flutter/widgets.dart';

Size _getScreenSize() {
  final window = WidgetsBinding.instance.platformDispatcher.implicitView;
  if (window == null) {
    throw StateError('Use context.rh() or context.rw() in multi-view apps.');
  }
  return window.physicalSize / window.devicePixelRatio;
}

/// Legacy single-view percentages. Prefer BuildContextX.rh/rw in widgets.
extension SizeExtensions on num {
  double get rh {
    final screenSize = _getScreenSize();
    return screenSize.height * (this / 100);
  }

  double get rw {
    final screenSize = _getScreenSize();
    return screenSize.width * (this / 100);
  }

  double get h => rh;

  double get w => rw;
}
