import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/notes/data/notes_repository.dart';
import 'package:noteworthy/features/notes/presentation/notes_controller.dart';

import '../data/fake_notes.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer makeProviderContainer(MockNotesRepository notesRepository) {
    final container = ProviderContainer(
      overrides: [
        notesRepositoryProvider.overrideWithValue(notesRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('initial state is AsyncData', () {
    final notesRepository = MockNotesRepository();
    final container = makeProviderContainer(notesRepository);
    final listener = Listener<AsyncValue<void>>();
    container.listen(
      noteControllerProvider,
      listener,
      fireImmediately: true,
    );
    // verify
    verify(
      // the build method returns a value immediately, so we expect AsyncData
      () => listener(null, const AsyncData<void>(null)),
    );
    verifyNoMoreInteractions(listener);
  });
}
