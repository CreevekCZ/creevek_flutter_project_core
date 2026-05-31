import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/features/home/screens/home_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  group('HomeScreen golden', () {
    goldenTest(
      'renders the default state',
      fileName: 'home_screen',
      builder: () => GoldenTestGroup(
        columns: 1,
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 390,
          height: 844,
        ),
        children: [
          GoldenTestScenario(
            name: 'default',
            child: buildTestApp(
              child: const HomeScreen(),
            ),
          ),
        ],
      ),
    );
  });
}
