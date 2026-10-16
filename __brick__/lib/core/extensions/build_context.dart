import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  bool get isPhone => screenSize.shortestSide < 600;

  bool get isSmallPhone => screenSize.width < 360;

  bool get isTablet => screenSize.shortestSide >= 600;

  bool get isDesktop => screenSize.width >= 1200;

  bool get isLandscape => MediaQuery.orientationOf(this) == .landscape;

  bool get isPortrait => MediaQuery.orientationOf(this) == .portrait;

  /// Percentages of this widget's view, with automatic rebuilds on resize.
  double rh(num percent) => screenSize.height * percent / 100;

  double rw(num percent) => screenSize.width * percent / 100;
}
