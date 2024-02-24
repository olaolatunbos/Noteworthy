import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/notes/data/notes_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'package:noteworthy/routing/app_router.dart';
import 'package:noteworthy/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes_controller.g.dart';

@riverpod
class NoteController extends _$NoteController with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // used for initialisation
    // async notifier of type void so we do not need to do anything
  }

  Future<void> createNote(
      {required String title,
      required String content,
      required String color,
      required String group,
      required void Function() onSuccess}) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepositoryProvider).currentUser;
    final newState = await AsyncValue.guard(() => ref
        .read(notesRepositoryProvider)
        .createNote(
            title: title,
            content: content,
            uid: user!.uid,
            color: color,
            group: group));
    if (mounted) {
      state = newState;
      if (state.hasError == false) {
        onSuccess();
      }
    }
    onSuccess();
  }

  Future<void> updateNote(
      {required Note note,
      required String title,
      required String content,
      required String color}) async {
    state = const AsyncValue.loading();
    final updatedNote =
        note.copyWith(title: title, content: content, color: color);
    state = await AsyncValue.guard(
        () => ref.read(notesRepositoryProvider).updateNote(updatedNote));
    state.hasError == false;
  }

  Future<void> categoriseNote(
      {required Note note, required String group}) async {
    state = const AsyncValue.loading();
    final updatedNote = note.copyWith(group: group);
    state = await AsyncValue.guard(
        () => ref.read(notesRepositoryProvider).updateNote(updatedNote));
    state.hasError == false;
  }

  Future<void> deleteNote(
      {required Note note, required void Function() onSuccess}) async {
    state = const AsyncValue.loading();
    final newState = await AsyncValue.guard(
        () => ref.read(notesRepositoryProvider).deleteNote(note.id));
    if (mounted) {
      state = newState;
      if (state.hasError == false) {
        onSuccess();
      }
    }
    onSuccess();
  }
}
