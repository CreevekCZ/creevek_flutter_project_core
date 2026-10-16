import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/core/app.dart';
import 'package:{{packageName}}/di.dart';
import 'package:{{packageName}}/features/language_settings/language_cubit/language_cubit.dart';

import '../helpers/hydrated_bloc_storage.dart';

void main() {
  testWidgets(
    'uses dark colors and leaves the DI-owned cubit open on unmount',
    (
      tester,
    ) async {
      setupHydratedBlocStorage();
      final cubit = LanguageCubit(systemLocale: const Locale('en'));
      sl.pushNewScope();
      sl.registerSingleton<LanguageCubit>(cubit, dispose: disposeLanguageCubit);
      sl.registerFactory<AppRouteObserver>(AppRouteObserver.new);
      addTearDown(() async {
        await sl.popScope();
      });
      tester.platformDispatcher.platformBrightnessTestValue = .dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final context = tester.element(find.text('Home Screen'));
      expect(Theme.of(context).brightness, Brightness.dark);

      await tester.pumpWidget(const SizedBox());
      expect(cubit.isClosed, isFalse);
      expect(tester.takeException(), isNull);
      await sl.resetScope();
      expect(cubit.isClosed, isTrue);
    },
  );

  testWidgets(
    'orientation uses display width even when the view is letterboxed',
    (
      tester,
    ) async {
      final requests = <List<dynamic>>[];
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'SystemChrome.setPreferredOrientations') {
          requests.add(call.arguments as List<dynamic>);
        }
        return null;
      });
      addTearDown(
        () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
      );
      addTearDown(tester.view.reset);
      addTearDown(tester.view.display.reset);
      tester.view.devicePixelRatio = 1;
      tester.view.display.size = const Size(1000, 800);
      tester.view.physicalSize = const Size(400, 800);

      late BuildContext context;
      await tester.pumpWidget(
        Builder(
          builder: (value) {
            context = value;
            return const SizedBox();
          },
        ),
      );
      await setDefaultOrientation(context);
      expect(requests.last, isEmpty);

      tester.view.display.size = const Size(400, 800);
      await setDefaultOrientation(context);
      expect(requests.last, ['DeviceOrientation.portraitUp']);
    },
  );
}
