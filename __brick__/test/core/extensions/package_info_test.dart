import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:{{packageName}}/core/environment/app_environment.dart';
import 'package:{{packageName}}/core/extensions/package_info.dart';

void main() {
  group('PackageInfoPlus', () {
    test('reads the environment from the FLAVOR define', () {
      final packageInfo = PackageInfo(
        appName: 'Test App',
        packageName: 'prod',
        version: '1.0.0',
        buildNumber: '1',
      );
      const flavorNameFromEnv = String.fromEnvironment('FLAVOR');

      expect(
        packageInfo.appEnvironment,
        AppEnvironment.fromString(flavorNameFromEnv),
      );
    });
  });
}
