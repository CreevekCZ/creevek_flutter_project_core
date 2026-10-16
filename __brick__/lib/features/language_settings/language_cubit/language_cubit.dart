import 'dart:ui';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../l10n/app_localizations.dart';

class LanguageCubit({required final Locale _systemLocale})
    extends HydratedCubit<Locale?> {
  this : super(null) {
    final currentState = state;

    if (currentState == null) {
      emit(_systemLocale);
    }
  }

  @override
  String get storagePrefix => 'LanguageCubit';

  Locale get currentLocale => state ?? _systemLocale;

  void changeLanguage(Locale locale) {
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic>? json) {
    if (json case {'languageCode': final String languageCode}
        when languageCode.isNotEmpty) {
      return Locale.fromSubtags(
        languageCode: languageCode,
        scriptCode: _optionalSubtag(json['scriptCode']),
        countryCode: _optionalSubtag(json['countryCode']),
      );
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(Locale? state) {
    if (state == null) {
      return null;
    }

    return {
      'languageCode': state.languageCode,
      'scriptCode': ?state.scriptCode,
      'countryCode': ?state.countryCode,
    };
  }

  String? _optionalSubtag(Object? value) => switch (value) {
    final String code when code.isNotEmpty => code,
    _ => null,
  };

  void save() {
    final currentState = state;
    if (currentState != null) {
      emit(currentState);
    }
  }

  AppLocalizations getL10n() {
    return lookupAppLocalizations(state ?? _systemLocale);
  }
}
