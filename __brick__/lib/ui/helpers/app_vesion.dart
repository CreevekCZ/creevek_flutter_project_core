import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:{{packageName}}/di.dart';

class AppVesion extends StatelessWidget {
  const AppVesion({super.key});

  @override
  Widget build(BuildContext context) {
    String verisonString;

    if (kIsWeb) {
      verisonString = sl<PackageInfo>().version;
    } else {
      verisonString = '${sl<PackageInfo>().version} (${sl<PackageInfo>().buildNumber})';
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        verisonString,
        textAlign: TextAlign.center,
      ),
    );
  }
}
