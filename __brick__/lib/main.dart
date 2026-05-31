import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/app_setup.dart';

Future<void> main() async {
  await AppSetup.instance.init();

  runApp(const App());
}
