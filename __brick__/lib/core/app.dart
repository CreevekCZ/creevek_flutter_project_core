import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:{{packageName}}/core/extensions/build_context.dart';
import 'package:{{packageName}}/di.dart';
import 'package:{{packageName}}/features/language_settings/language_cubit/language_cubit.dart';
import 'package:{{packageName}}/l10n/app_localizations.dart';
import 'package:{{packageName}}/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter();

  late final LanguageCubit _languageCubit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setDefaultOrientation(context);
    });

    _languageCubit = sl<LanguageCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _languageCubit),
      ],
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
            routerConfig: _router.config(navigatorObservers: () => [sl<AppRouteObserver>()]),
            theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
            darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
            builder: (context, child) => child!,
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
class AppRouteObserver extends AutoRouterObserver {
  AppRouteObserver();

  final Logger logger = Logger('AutoRoute');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final message =
        '${ConsoleColors.green}Pushed: ${"${route.settings.name} ${route.settings.arguments}"}${ConsoleColors.reset}';
    logger.finest(message);
  }
}

Future<void> setDefaultOrientation(BuildContext context) async {
  if (context.isPhone) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } else {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
