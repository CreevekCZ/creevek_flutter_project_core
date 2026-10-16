import 'package:flutter/widgets.dart';

/// Rebuilds when the surrounding view's logical size changes.
class const ResponsiveBuilder({
  required final Widget Function(BuildContext context) builder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return builder(context);
  }
}
