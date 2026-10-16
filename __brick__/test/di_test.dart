import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:{{packageName}}/core/environment/app_environment_provider.dart';
import 'package:{{packageName}}/core/network/app_api_client.dart';
import 'package:{{packageName}}/di.dart';
import 'package:{{packageName}}/features/language_settings/language_cubit/language_cubit.dart';

import 'helpers/hydrated_bloc_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'generated DI constructs primary classes and owns Cubit disposal',
    () async {
      sl.pushNewScope();
      addTearDown(sl.popScope);
      setupHydratedBlocStorage();
      PackageInfo.setMockInitialValues(
        appName: 'Test',
        packageName: 'test.app',
        version: '1.2.3',
        buildNumber: '45',
        buildSignature: '',
      );

      await configureDependencies();

      final environment = sl<AppEnvironmentProvider>();
      expect(environment.appVersion, '1.2.3');
      expect(environment.appBuildNumber, '45');
      expect(environment.packageName, 'test.app');
      expect(sl<AppApiClient>(), isA<AppApiClient>());
      final cubit = sl<LanguageCubit>();
      expect(sl<LanguageCubit>(), same(cubit));
      await sl.resetScope();
      expect(cubit.isClosed, isTrue);
    },
  );
}
