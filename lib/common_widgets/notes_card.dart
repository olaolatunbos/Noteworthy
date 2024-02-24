import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'dart:core';

/// Used to show a single note inside a card.
class NoteCard extends ConsumerWidget {
  const NoteCard({super.key, required this.note, this.onPressed});
  final Note note;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const noteCardKey = Key('note-card');

  toColor(String s) {
    var hexColor = s.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: toColor(note.color),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              note.title,
              style: const TextStyle(
                  fontFamily: "Poppins", fontWeight: FontWeight.w500),
            ),
            gapH8,
            Text(
              note.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            )
          ]),
        ),
      ),
    );
  }
}
