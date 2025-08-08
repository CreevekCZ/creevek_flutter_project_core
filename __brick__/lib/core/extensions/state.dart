import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:{{packageName}}/core/extensions/l10n.dart';
import 'package:{{packageName}}/l10n/app_localizations.dart';

extension StateX on State {
  AppLocalizations get l10n => context.l10n;
  StackRouter get router => context.router;
}
