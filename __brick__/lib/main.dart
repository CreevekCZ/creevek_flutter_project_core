import 'package:flutter/material.dart';

import 'package:{{packageName}}/core/app_setup.dart';
import 'core/app.dart';

Future<void> main() async {
  await AppSetup.instance.init();

  runApp(const App());
}
