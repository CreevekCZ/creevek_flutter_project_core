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
      addTearDown(cubit.close);

      expect(cubit.currentLocale, const Locale('en'));
    });

    test('round trips script and country without losing locale subtags', () {
      final cubit = LanguageCubit(systemLocale: const Locale('en'));
      addTearDown(cubit.close);
      const locale = Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      );

      expect(cubit.fromJson(cubit.toJson(locale)), locale);
      expect(cubit.toJson(const Locale('en')), {'languageCode': 'en'});
    });

    test('reads legacy state and tolerates malformed persisted values', () {
      final cubit = LanguageCubit(systemLocale: const Locale('en'));
      addTearDown(cubit.close);

      expect(cubit.fromJson({'languageCode': 'cs'}), const Locale('cs'));
      expect(cubit.fromJson(null), isNull);
      expect(cubit.fromJson({'languageCode': ''}), isNull);
      expect(cubit.fromJson({'languageCode': 42}), isNull);
      expect(
        cubit.fromJson({
          'languageCode': 'en',
          'scriptCode': false,
          'countryCode': '',
        }),
        const Locale('en'),
      );
    });
  });
}
