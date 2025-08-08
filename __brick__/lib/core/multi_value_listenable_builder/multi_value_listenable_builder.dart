import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{packageName}}/core/multi_value_listenable_builder/multi_value_listenable_builder_bloc.dart';
import 'package:{{packageName}}/core/multi_value_listenable_builder/multi_value_listenable_event.dart';

class MultiValueListenableBuilder extends StatefulWidget {
  const MultiValueListenableBuilder({
    required this.listenables,
    required this.builder,
    this.onChanged,
    super.key,
  });

  final List<ValueListenable<dynamic>> listenables;
  final Widget Function(BuildContext context) builder;
  final VoidCallback? onChanged;

  @override
  MultiValueListenableBuilderState createState() => MultiValueListenableBuilderState();
}

class MultiValueListenableBuilderState extends State<MultiValueListenableBuilder> {
  late final MultiValueListenableBloc _multiValueListenableBloc;

  @override
  void initState() {
    super.initState();

    _multiValueListenableBloc = MultiValueListenableBloc();

    for (final listenable in widget.listenables) {
      listenable.addListener(_update);
    }
  }

  @override
  void dispose() {
    for (final listenable in widget.listenables) {
      listenable.removeListener(_update);
    }

    _multiValueListenableBloc.close();
    super.dispose();
  }

  void _update() {
    if (mounted) {
      _multiValueListenableBloc.add(const MultiValueListenableEvent.updateView());
      if (widget.onChanged != null) {
        widget.onChanged!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiValueListenableBloc, String>(
      bloc: _multiValueListenableBloc,
      builder: (context, _) {
        return widget.builder(context);
      },
    );
  }
}
