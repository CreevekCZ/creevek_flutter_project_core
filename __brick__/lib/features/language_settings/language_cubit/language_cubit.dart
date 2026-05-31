import 'dart:ui';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../l10n/app_localizations.dart';

class LanguageCubit extends HydratedCubit<Locale?> {
  LanguageCubit({required Locale systemLocale})
    : _systemLocale = systemLocale,
      super(null) {
    final currentState = state;

    if (currentState == null) {
      emit(systemLocale);
    }
  }

  late final Locale _systemLocale;

  @override
  String get storagePrefix => 'LanguageCubit';

  Locale get currentLocale => state ?? _systemLocale;

  void changeLanguage(Locale locale) {
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    final languageCode = json['languageCode'];
    if (languageCode is! String || languageCode.isEmpty) {
      return null;
    }

    return Locale(languageCode);
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
