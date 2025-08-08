import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:{{packageName}}/core/environment/app_environment.dart';

@singleton
class AppEnvironmentProvider {
  AppEnvironmentProvider(this._packageInfo);

  final PackageInfo _packageInfo;

  AppEnvironment get environment {
    const flavorNameFromEnv = String.fromEnvironment('FLAVOR');

    return AppEnvironment.fromString(flavorNameFromEnv);
  }

  String get appVersion => _packageInfo.version;

  String get appBuildNumber => _packageInfo.buildNumber;

  String get packageName => _packageInfo.packageName;
}
