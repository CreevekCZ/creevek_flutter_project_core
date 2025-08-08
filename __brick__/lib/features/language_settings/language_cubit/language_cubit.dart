import 'dart:ui';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:{{packageName}}/l10n/app_localizations.dart';

class LanguageCubit extends HydratedCubit<Locale?> {
  LanguageCubit({required Locale systemLocale}) : _systemLocale = systemLocale, super(null) {
    final currentState = state;

    if (currentState == null) {
      emit(systemLocale);
    }
  }

  late final Locale _systemLocale;

  Locale get currentLocale => state ?? _systemLocale;

  void changeLanguage(Locale locale) {
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      emit(_systemLocale);
      return null;
    }

    try {
      return Locale(json['languageCode'] as String);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(Locale? state) {
    if (state == null) {
      return null;
    }

    try {
      return {'languageCode': state.languageCode};
    } catch (_) {
      return null;
    }
  }

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
