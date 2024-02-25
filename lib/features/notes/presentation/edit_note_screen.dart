import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteworthy/common_widgets/error_message_widget.dart';
import 'package:noteworthy/constants/colors.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/features/notes/data/notes_repository.dart';
import 'package:noteworthy/features/notes/domain/note.dart';
import 'package:noteworthy/features/notes/presentation/notes_controller.dart';
import 'package:noteworthy/localization/string_hardcoded.dart';
import 'package:noteworthy/utils/async_value_ui.dart';

/// Notes are first created in [AddNoteScreen]

class EditNoteScreen extends ConsumerWidget {
  const EditNoteScreen({super.key, required this.noteId});
  final NoteID noteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      noteControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final noteValue = ref.watch(noteStreamProvider(noteId));
    return noteValue.when(
      data: (note) => note != null
          ? EditScreenContents(note: note)
          : Scaffold(
              appBar: AppBar(title: Text('Edit Post'.hardcoded)),
              body: Center(
                child: ErrorMessageWidget('Post not found'.hardcoded),
              ),
            ),
      // * to prevent a black screen, return a [Scaffold] from the error and
      // * loading screens
      error: (e, st) =>
          Scaffold(body: Center(child: ErrorMessageWidget(e.toString()))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class EditScreenContents extends ConsumerStatefulWidget {
  const EditScreenContents({super.key, required this.note});
  final Note note;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditScreenContentsState();
}

class _EditScreenContentsState extends ConsumerState<EditScreenContents> {
  Note get note => widget.note;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text fields with post data
    _titleController.text = note.title;
    _contentController.text = note.content;
  }

  toColor(String s) {
    var hexColor = s.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  void bookmark() {
    if (note.group == "bookmarked") {
      ref
          .read(noteControllerProvider.notifier)
          .categoriseNote(note: note, group: "");
    } else {
      ref
          .read(noteControllerProvider.notifier)
          .categoriseNote(note: note, group: "bookmarked");
    }
  }

  void important() {
    if (note.group == "important") {
      ref
          .read(noteControllerProvider.notifier)
          .categoriseNote(note: note, group: "");
    } else {
      ref
          .read(noteControllerProvider.notifier)
          .categoriseNote(note: note, group: "important");
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteControllerProvider);
    final isLoading = state.isLoading;
    String selected = "";
    return Scaffold(
      backgroundColor: toColor(note.color),
      appBar: AppBar(
        backgroundColor: toColor(note.color),
        actions: [
          IconButton(
            onPressed: () => important(),
            icon: note.group == "important"
                ? const Icon(Icons.star)
                : const Icon(Icons.star_outline),
          ),
          IconButton(
              onPressed: () => bookmark(),
              icon: note.group == "bookmarked"
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_outline)),
          IconButton(
              onPressed: isLoading
                  ? null
                  : () => ref.read(noteControllerProvider.notifier).deleteNote(
                        note: note,
                      ),
              icon: const Icon(Icons.delete_outline)),
          IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.post_add_outlined)),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(
            Sizes.p16, Sizes.p16, Sizes.p16, Sizes.p60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
                controller: _titleController,
                enabled: !isLoading,
                style: const TextStyle(
                    fontSize: 20, color: Colors.black, fontFamily: "Poppins"),
                cursorColor: Colors.black,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  hintText: "Title...",
                  hintStyle: TextStyle(
                      fontSize: 20, color: Colors.grey, fontFamily: "Poppins"),
                  border: InputBorder.none,
                )),
            gapH8,
            TextFormField(
              controller: _contentController,
              enabled: !isLoading,
              style:
                  const TextStyle(color: Colors.black, fontFamily: "Poppins"),
              decoration: const InputDecoration(
                hintText: "Type note here...",
                hintStyle: TextStyle(
                    fontSize: 16, color: Colors.grey, fontFamily: "Poppins"),
                border: InputBorder.none,
              ),
              cursorColor: Colors.black,
              enableInteractiveSelection: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const Spacer(),
            MaterialColorPicker(
              circleSize: 40,
              allowShades: false,
              spacing: 22,
              selectedColor: toColor(note.color),
              onMainColorChange: (ColorSwatch? color) {
                // Handle color changes
                selected = '#${color!.value.toRadixString(16).substring(2)}';
                ref.read(noteControllerProvider.notifier).updateNote(
                      note: note,
                      title: _titleController.text,
                      content: _contentController.text,
                      color: selected,
                    );
              },
              colors: [pink, blue, brown, yellow],
            ),
          ],
        ),
      ),
    );
  }
}
