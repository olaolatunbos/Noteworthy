import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noteworthy/features/notes/data/notes_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'fake_notes.dart';

void main() {
  FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();

  setUp(() {
    // add notes to firstore collection
    final collection = fakeFirestore.collection('notes');
    fakeNotes.forEach((item) async {
      await collection.doc(item.id).set(item.toMap());
    });
  });

  group("NotesRepository", () {
    test("fetchNote('note1') returns correct note", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(await notesRepository.fetchNote("note1"), note1);
    });
    test("fetchNote('note100') returns null", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(await notesRepository.fetchNote("note100"), null);
    });
    test("fetchUserNotes('user1') returns global list", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(await notesRepository.fetchUserNotes('user1'), fakeNotes);
    });
    test("watchUserNotesByGroup('user1', 'important') returns global list", () {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(notesRepository.watchUserNotesByGroup('user1', 'important'),
          emits(fakeNotes));
    });
    test("watchNote('note1') returns correct item", () {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(notesRepository.watchNote('note1'), emits(note1));
    });
    test("watchNote('note001') returns null", () {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(notesRepository.watchNote('note100'), emits(null));
    });
    test("watchUserNotes('user1') returns global list", () {
      final notesRepository = NotesRepository(fakeFirestore);
      expect(notesRepository.watchUserNotes('user1'), emits(fakeNotes));
    });
    test("createNote(note) adds note to database", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      await notesRepository.createNote(
          title: 'Plan for Sunday',
          content: 'wash the car',
          uid: "user1",
          color: "ffda1",
          group: "important");
      final noteId = ((await notesRepository.fetchUserNotes('user1')).last).id;
      Note newNote = Note(
          id: noteId,
          title: 'Plan for Sunday',
          content: 'wash the car',
          uid: "user1",
          color: "ffda1",
          group: "important");
      expect(await notesRepository.fetchNote(noteId), newNote);
    });
    test("deleteNote('note1') deletes note", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      await notesRepository.deleteNote('note1');
      expect(await notesRepository.fetchNote('note1'), null);
    });
    test("updateNote(note1) updates note", () async {
      final notesRepository = NotesRepository(fakeFirestore);
      Note updatedNote = const Note(
          id: "note1",
          title: 'Plan for Sunday',
          content: 'wash the car',
          uid: "user1",
          color: "ffda1",
          group: "important");
      await notesRepository.updateNote(updatedNote);
      expect(await notesRepository.fetchNote('note1'), updatedNote);
    });
  });
}
