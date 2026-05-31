import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockHydratedStorage extends Mock implements Storage {}

Storage setupHydratedBlocStorage() {
  final storage = MockHydratedStorage();

  when<dynamic>(() => storage.read(any())).thenReturn(null);
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  when(() => storage.delete(any())).thenAnswer((_) async {});
  when(() => storage.clear()).thenAnswer((_) async {});
  when(() => storage.close()).thenAnswer((_) async {});

  HydratedBloc.storage = storage;

  return storage;
}
