import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_value_listenable_event.freezed.dart';

@freezed
sealed class MultiValueListenableEvent with _$MultiValueListenableEvent {
  const factory MultiValueListenableEvent.updateView() = MultiValueListenableUpdateViewEvent;
}
