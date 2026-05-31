import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'l10n.dart';

extension StateX on State {
  AppLocalizations get l10n => context.l10n;
  StackRouter get router => context.router;
}
