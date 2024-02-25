import 'package:flutter/material.dart';

/// Text button to be used as an [AppBar] action
class ActionTextButton extends StatelessWidget {
  const ActionTextButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(color: Colors.black, fontFamily: "Poppins")),
      ),
    );
  }
}
