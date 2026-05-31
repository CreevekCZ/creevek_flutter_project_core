import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:{{packageName}}/l10n/app_localizations.dart';

Widget buildTestApp({
  required Widget child,
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    home: child,
  );
}
