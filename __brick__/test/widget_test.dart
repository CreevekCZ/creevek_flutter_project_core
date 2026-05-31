import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/features/home/screens/home_screen.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('renders the home screen', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        child: const HomeScreen(),
      ),
    );

    expect(find.text('Home Screen'), findsOneWidget);
  });
}
