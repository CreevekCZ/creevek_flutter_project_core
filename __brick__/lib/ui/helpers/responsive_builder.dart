import 'package:flutter/widgets.dart';

import 'package:{{packageName}}/core/services/responsive_size_service.dart';

class ResponsiveBuilder extends StatefulWidget {
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context) builder;

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  @override
  void initState() {
    super.initState();
    ResponsiveSizeService.instance.addListener(_handleSizeChange);
  }

  @override
  void dispose() {
    ResponsiveSizeService.instance.removeListener(_handleSizeChange);
    super.dispose();
  }

  void _handleSizeChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
