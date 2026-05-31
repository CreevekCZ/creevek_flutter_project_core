import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../di.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    String versionString;

    if (kIsWeb) {
      versionString = sl<PackageInfo>().version;
    } else {
      versionString =
          '${sl<PackageInfo>().version} (${sl<PackageInfo>().buildNumber})';
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        versionString,
        textAlign: TextAlign.center,
      ),
    );
  }
}
