import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:{{packageName}}/features/language_settings/language_cubit/language_cubit.dart';

import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() async => sl.init();

@module
abstract class AppModule {
  @preResolve
  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();

  @preResolve
  Future<LanguageCubit> getLanguageCubit() async {
    final systemLocale = PlatformDispatcher.instance.locale;

    return LanguageCubit(systemLocale: systemLocale);
  }
}
