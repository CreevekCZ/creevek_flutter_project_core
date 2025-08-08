import 'package:package_info_plus/package_info_plus.dart';

import 'package:{{packageName}}/core/environment/app_environment.dart';

extension PackageInfoPlus on PackageInfo {
  AppEnvironment get appEnvironment {
    final env = packageName;
    return AppEnvironment.fromString(env);
  }
}
