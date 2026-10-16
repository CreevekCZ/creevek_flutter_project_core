import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../di.dart';

class const AppVersion({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Flutter 3.47 embeds these in the binary, including web builds.
    final version = appBuildName ?? sl<PackageInfo>().version;
    final buildNumber = kIsWeb
        ? null
        : appBuildNumber ?? sl<PackageInfo>().buildNumber;
    final versionString = buildNumber == null || buildNumber.isEmpty
        ? version
        : '$version ($buildNumber)';

    return Align(
      alignment: .bottomCenter,
      child: Text(
        versionString,
        textAlign: .center,
      ),
    );
  }
}
