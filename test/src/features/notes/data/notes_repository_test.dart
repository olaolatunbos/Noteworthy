// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:noteworthy/features/notes/data/notes_repository.dart';
// import 'package:noteworthy/features/notes/domain/note.dart';

// const notesCollection = 'notes';

// void main() {
//   Note note = const Note(
//       title: "Title1",
//       color: "blue",
//       group: "important",
//       uid: "user1",
//       id: "note1",
//       content: "Content1");
//   List<Note> notes = [note];
//   NotesRepository makeNotesRepository() {
//     final fakeFirestore = FakeFirebaseFirestore();
//     return NotesRepository(fakeFirestore);
//   }

//   setUp(() {});

//   group("NotesRepository", () {
//     test("fetch note from firestore", () async {
//       final notesRepository = makeNotesRepository();
//       await fakeFirestore
//           .collection(notesCollection)
//           .doc('note1')
//           .set(note.toMap());
//       expect(await notesRepository.fetchNote("note1"), note);
//     });
//     test("fetch invalid note from firestore", () async {
//       final fakeFirestore = FakeFirebaseFirestore();
//       final notesRepository = NotesRepository(fakeFirestore);
//       expect(await notesRepository.fetchNote("note100"), note);
//     });
//   });
// }
