import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteworthy/common_widgets/async_value_widget.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/features/notes/data/notes_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'package:noteworthy/common_widgets/notes_card.dart';

class AllNotesGrid extends ConsumerWidget {
  const AllNotesGrid({super.key, this.onPressed});
  final void Function(BuildContext, NoteID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesListValue = ref.watch(notesListStreamProvider);
    return AsyncValueWidget<List<Note>>(
      value: notesListValue,
      data: (notes) => GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Sizes.p8,
              crossAxisSpacing: Sizes.p8),
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onPressed: () => onPressed?.call(context, note.id),
            );
          }),
    );
  }
}

class ImportantNotesGrid extends ConsumerWidget {
  const ImportantNotesGrid({super.key, this.onPressed});
  final void Function(BuildContext, NoteID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesListValue = ref.watch(importantNotesStreamProvider);
    return AsyncValueWidget<List<Note>>(
      value: notesListValue,
      data: (notes) => ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onPressed: () => onPressed?.call(context, note.id),
            );
          }),
    );
  }
}

class BookmarkedNotesGrid extends ConsumerWidget {
  const BookmarkedNotesGrid({super.key, this.onPressed});
  final void Function(BuildContext, NoteID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesListValue = ref.watch(bookmarkedNotesStreamProvider);
    return AsyncValueWidget<List<Note>>(
      value: notesListValue,
      data: (notes) => ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return NoteCard(
              note: note,
              onPressed: () => onPressed?.call(context, note.id),
            );
          }),
    );
  }
}
