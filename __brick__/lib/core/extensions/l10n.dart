import 'package:flutter/material.dart';

import 'package:{{packageName}}/l10n/app_localizations.dart';

extension L10nExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
