import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  bool get isPhone =>
      (isPortrait ? MediaQuery.of(this).size.width : MediaQuery.of(this).size.height) < 600;

  bool get isSmallPhone => MediaQuery.of(this).size.width < 360;

  bool get isTablet =>
      (isPortrait ? MediaQuery.of(this).size.width : MediaQuery.of(this).size.height) >= 600;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
}
