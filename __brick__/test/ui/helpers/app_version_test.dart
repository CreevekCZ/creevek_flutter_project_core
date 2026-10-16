import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:{{packageName}}/di.dart';
import 'package:{{packageName}}/ui/helpers/app_version.dart';

void main() {
  testWidgets('renders build metadata with a PackageInfo fallback', (
    tester,
  ) async {
    sl.pushNewScope();
    addTearDown(sl.popScope);
    sl.registerSingleton<PackageInfo>(
      PackageInfo(
        appName: 'Test',
        packageName: 'test.app',
        version: '2.0.0',
        buildNumber: '42',
      ),
    );

    await tester.pumpWidget(const MaterialApp(home: AppVersion()));

    const version = appBuildName ?? '2.0.0';
    const buildNumber = appBuildNumber ?? '42';
    expect(
      find.text(buildNumber.isEmpty ? version : '$version ($buildNumber)'),
      findsOneWidget,
    );
  });

  testWidgets(
    'embedded metadata renders without a PackageInfo registration',
    (tester) async {
      sl.pushNewScope();
      addTearDown(sl.popScope);
      await tester.pumpWidget(const MaterialApp(home: AppVersion()));
      expect(find.byType(Text), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
    skip: appBuildName == null || appBuildNumber == null,
  );
}
