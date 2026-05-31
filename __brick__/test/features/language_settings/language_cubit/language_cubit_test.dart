import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/features/language_settings/language_cubit/language_cubit.dart';

import '../../../helpers/hydrated_bloc_storage.dart';

void main() {
  group('LanguageCubit', () {
    setUp(setupHydratedBlocStorage);

    blocTest<LanguageCubit, Locale?>(
      'emits the selected locale',
      build: () => LanguageCubit(systemLocale: const Locale('en')),
      act: (cubit) => cubit.changeLanguage(const Locale('cs')),
      expect: () => [const Locale('cs')],
    );

    test('uses the system locale when there is no hydrated state', () {
      final cubit = LanguageCubit(systemLocale: const Locale('en'));

      expect(cubit.currentLocale, const Locale('en'));
    });
  });
}
