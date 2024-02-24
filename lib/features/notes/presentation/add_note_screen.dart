// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteworthy/constants/colors.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/features/notes/presentation/notes_controller.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreen();
}

class _AddNoteScreen extends ConsumerState<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _informationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _informationController.dispose();
    super.dispose();
  }

// Creating a ColorSwatch using the primary constructor

  @override
  Widget build(BuildContext context) {
    const isLoading = false;
    String selectedColor = "";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: isLoading
                  ? null
                  : () => ref.read(noteControllerProvider.notifier).createNote(
                        title: _titleController.text,
                        content: _informationController.text,
                        group: "",
                        color: selectedColor,
                        onSuccess: context.pop,
                      ),
              icon: const Icon(Icons.post_add_outlined))
        ],
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
              ),
              // validator:
              //     ref.read(productValidatorProvider).titleValidator,
            ),
            gapH12,
            TextFormField(
              controller: _informationController,
              enabled: !isLoading,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black, fontFamily: "Poppins"),
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
            Center(
              child: MaterialColorPicker(
                circleSize: 40,
                allowShades: false,
                spacing: 22,
                onMainColorChange: (ColorSwatch? color) {
                  // Handle color changes
                  selectedColor =
                      '#${color!.value.toRadixString(16).substring(2)}';
                },
                colors: [pink, blue, brown, yellow],
              ),
            )
          ],
        ),
      ),
    );
  }
}
