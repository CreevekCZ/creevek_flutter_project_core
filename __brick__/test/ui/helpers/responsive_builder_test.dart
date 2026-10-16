import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{packageName}}/core/extensions/build_context.dart';
import 'package:{{packageName}}/ui/helpers/responsive_builder.dart';

void main() {
  testWidgets('uses the surrounding view and rebuilds only for size changes', (
    tester,
  ) async {
    final data = ValueNotifier(
      const MediaQueryData(size: Size(400, 800)),
    );
    addTearDown(data.dispose);
    var builds = 0;
    late Size size;
    late double halfWidth;
    late double quarterHeight;
    late bool isPhone;

    await tester.pumpWidget(
      ValueListenableBuilder<MediaQueryData>(
        valueListenable: data,
        builder: (context, value, child) => MediaQuery(
          data: value,
          child: child!,
        ),
        child: ResponsiveBuilder(
          builder: (context) {
            builds++;
            size = context.screenSize;
            halfWidth = context.rw(50);
            quarterHeight = context.rh(25);
            isPhone = context.isPhone;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(size, const Size(400, 800));
    expect(halfWidth, 200);
    expect(quarterHeight, 200);
    expect(isPhone, isTrue);
    expect(builds, 1);

    data.value = data.value.copyWith(
      viewInsets: const EdgeInsets.only(bottom: 200),
    );
    await tester.pump();
    expect(builds, 1);

    data.value = data.value.copyWith(size: const Size(1200, 800));
    await tester.pump();
    expect(size, const Size(1200, 800));
    expect(halfWidth, 600);
    expect(isPhone, isFalse);
    expect(builds, 2);
  });
}
