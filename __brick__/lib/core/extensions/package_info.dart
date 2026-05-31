import 'package:package_info_plus/package_info_plus.dart';

import '../environment/app_environment.dart';

extension PackageInfoPlus on PackageInfo {
  AppEnvironment get appEnvironment {
    const flavorNameFromEnv = String.fromEnvironment('FLAVOR');

    return AppEnvironment.fromString(flavorNameFromEnv);
  }
}
