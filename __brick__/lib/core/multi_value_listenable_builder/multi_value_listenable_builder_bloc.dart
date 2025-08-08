import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:{{packageName}}/core/multi_value_listenable_builder/multi_value_listenable_event.dart';

class MultiValueListenableBloc extends Bloc<MultiValueListenableEvent, String> {
  MultiValueListenableBloc() : super(const Uuid().v4()) {
    on<MultiValueListenableEvent>(
      (event, emit) => event.maybeMap(
        updateView: (_) => emit(const Uuid().v4()),
        orElse: () => throw UnimplementedError(),
      ),
      transformer: sequential(),
    );
  }
}
