import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:{{packageName}}/core/environment/app_environment.dart';
import 'package:{{packageName}}/core/extensions/package_info.dart';
import 'package:{{packageName}}/core/services/responsive_size_service.dart';
import 'package:{{packageName}}/di.dart';

class AppSetup {
  AppSetup._();

  static AppSetup instance = AppSetup._();

  AppEnvironment get environment => sl<PackageInfo>().appEnvironment;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    setupWeb();
    await _setupHive();
    await _setupHydratedBloc();
    await _setupDependencies();
    _setupResponsiveSizeService();
  }

  Future<void> _setupHive() async {
    await Hive.initFlutter();

    await Hive.openBox<String>(HiveBoxesKeys.userCache);
  }

  Future<void> _setupHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }

  void _setupResponsiveSizeService() {
    ResponsiveSizeService.instance.init();
  }

  Future<void> _setupDependencies() async {
    await configureDependencies();
  }

  void setupWeb() {
    if (!kIsWeb) {
      return;
    }

    usePathUrlStrategy();
  }
}

abstract class HiveBoxesKeys {
  static const String userCache = 'user_cache';
}

abstract class FeatureFlags {
  static bool devTools = kDebugMode;
  // static bool devTools = false;

  static bool get isDev => sl<PackageInfo>().appEnvironment == AppEnvironment.dev;
}
