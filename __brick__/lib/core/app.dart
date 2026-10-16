import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../di.dart';
import '../features/language_settings/language_cubit/language_cubit.dart';
import '../l10n/app_localizations.dart';
import '../routes.dart';

class const App({super.key}) extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _router = AppRouter();

  late final LanguageCubit _languageCubit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _languageCubit = sl<LanguageCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    unawaited(setDefaultOrientation(context));
  }

  @override
  void didChangeMetrics() {
    unawaited(setDefaultOrientation(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _languageCubit,
      child: BlocBuilder<LanguageCubit, Locale?>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: '{{packageName}}',
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            showPerformanceOverlay: false,
            routerConfig: _router.config(
              navigatorObservers: () => [sl<AppRouteObserver>()],
            ),
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            darkTheme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: .dark,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ConsoleColors {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

@injectable
class AppRouteObserver() extends AutoRouterObserver {
  final Logger logger = Logger('AutoRoute');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final message =
        '${ConsoleColors.green}Pushed: ${"${route.settings.name} ${route.settings.arguments}"}${ConsoleColors.reset}';
    logger.finest(message);
  }
}

Future<void> setDefaultOrientation(BuildContext context) async {
  // A letterboxed MediaQuery size is not the physical display's logical size.
  final display = View.maybeOf(context)?.display;
  if (display == null) {
    return;
  }

  await SystemChrome.setPreferredOrientations(
    display.size.width / display.devicePixelRatio < 600 ? [.portraitUp] : [],
  );
}
