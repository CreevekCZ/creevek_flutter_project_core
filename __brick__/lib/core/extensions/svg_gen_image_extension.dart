import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

extension SvgGenImageExtension on SvgGenImage {
  Widget whiteSvg({double? height, double? width}) =>
      coloredSvg(height: height, width: width, color: Colors.white);

  Widget primarySvg(BuildContext context, {double? height, double? width}) =>
      coloredSvg(
        height: height,
        width: width,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.blue
            : Colors.white,
      );

  Widget coloredSvg({required Color color, double? height, double? width}) =>
      svg(
        height: height,
        width: width,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
}
