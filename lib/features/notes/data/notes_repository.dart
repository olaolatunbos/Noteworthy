import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'notes_repository.g.dart';

class NotesRepository {
  const NotesRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String notesPath() => 'notes';
  static String notePath(NoteID id) => 'notes/$id';

  // one time read
  Future<List<Note>> fetchUserNotes(String uid) async {
    final ref = _notesRef().where('uid', isEqualTo: uid);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Note>> watchUserNotesByGroup(String uid, String group) {
    final ref = _notesRef()
        .where('uid', isEqualTo: uid)
        .where('group', isEqualTo: group);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  // realtime listeners, UI will update every time the data changes on the backend.
  Stream<List<Note>> watchUserNotes(String uid) {
    final ref = _notesRef().where('uid', isEqualTo: uid);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Note?> fetchNote(NoteID id) async {
    final ref = _noteRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Note?> watchNote(NoteID id) {
    final ref = _noteRef(id);
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
    final ref = _noteRef(noteId);

    return ref.set(note);
  }

  Future<void> deleteNote(NoteID id) {
    return _firestore.doc("notes/$id").delete();
  }

  Future<void> updateNote(Note note) {
    final ref = _noteRef(note.id);
    return ref.set(note);
  }

  DocumentReference<Note> _noteRef(NoteID id) =>
      _firestore.doc(notePath(id)).withConverter(
            fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
            toFirestore: (Note product, options) => product.toMap(),
          );

  Query<Note> _notesRef() => _firestore.collection(notesPath()).withConverter(
        fromFirestore: (doc, _) => Note.fromMap(doc.data()!),
        toFirestore: (Note product, options) => product.toMap(),
      );
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
