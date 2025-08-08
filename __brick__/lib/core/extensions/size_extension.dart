import 'package:flutter/widgets.dart';

Size _getScreenSize() {
  final window = WidgetsBinding.instance.platformDispatcher.views.first;
  return window.physicalSize / window.devicePixelRatio;
}

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
