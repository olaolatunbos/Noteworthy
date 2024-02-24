import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notes_repository.g.dart';

class NotesRepository {
  const NotesRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // one time read
  Future<List<Note>> fetchUserNotes(String uid) async {
    final ref = _firestore
        .collection('notes')
        .withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        )
        .where('uid', isEqualTo: uid);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Note>> watchUserNotesByGroup(String uid, String group) {
    final ref = _firestore
        .collection('notes')
        .withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        )
        .where('uid', isEqualTo: uid)
        .where('group', isEqualTo: group);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  // realtime listeners, UI will update every time the data changes on the backend.
  Stream<List<Note>> watchUserNotes(String uid) {
    final ref = _firestore
        .collection('notes')
        .withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        )
        .where('uid', isEqualTo: uid);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Note?> fetchNote(NoteID id) async {
    final ref = _firestore.doc('notes/$id').withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        );
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Note?> watchNote(NoteID id) {
    final ref = _firestore.doc('notes/$id').withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        );
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<void> createNote(
      {required String title,
      required String content,
      required String color,
      required String group,
      required String uid}) {
    String noteId = const Uuid().v1();
    Note note = Note(
        id: noteId,
        title: title,
        content: content,
        color: color,
        group: group,
        uid: uid);
    final ref = _firestore.doc('notes/$noteId').withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        );

    return ref.set(note);
  }

  Future<void> deleteNote(NoteID id) {
    return _firestore.doc("notes/$id").delete();
  }

  Future<void> updateNote(Note note) {
    final ref = _firestore.doc('notes/${note.id}').withConverter(
          fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
          toFirestore: (Note note, options) => note.toMap(),
        );
    return ref.set(note);
  }
}

@Riverpod(keepAlive: true)
NotesRepository notesRepository(NotesRepositoryRef ref) {
  return NotesRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Note>> notesListStream(NotesListStreamRef ref) {
  final notesRepostiory = ref.watch(notesRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser;
  return notesRepostiory.watchUserNotes(user!.uid);
}

@riverpod
Future<List<Note>> notesListFuture(NotesListFutureRef ref) {
  final notesRepostiory = ref.watch(notesRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser;
  return notesRepostiory.fetchUserNotes(user!.uid);
}

@riverpod
Stream<List<Note>> importantNotesStream(ImportantNotesStreamRef ref) {
  final notesRepostiory = ref.watch(notesRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser;
  return notesRepostiory.watchUserNotesByGroup(user!.uid, 'important');
}

@riverpod
Stream<List<Note>> bookmarkedNotesStream(BookmarkedNotesStreamRef ref) {
  final notesRepostiory = ref.watch(notesRepositoryProvider);
  final user = ref.read(authRepositoryProvider).currentUser;
  return notesRepostiory.watchUserNotesByGroup(user!.uid, 'bookmarked');
}

@riverpod
Stream<Note?> noteStream(NoteStreamRef ref, NoteID id) {
  final notesRepostiory = ref.watch(notesRepositoryProvider);
  return notesRepostiory.watchNote(id);
}

@riverpod
Future<Note?> noteFuture(NoteFutureRef ref, NoteID id) {
  final notesRepository = ref.watch(notesRepositoryProvider);
  return notesRepository.fetchNote(id);
}
