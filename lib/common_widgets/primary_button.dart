import 'package:flutter/material.dart';
import 'package:noteworthy/constants/sizes.dart';

/// Primary button based on [ElevatedButton]. Useful for CTAs in the app.
class PrimaryButton extends StatelessWidget {
  /// Create a PrimaryButton.
  /// if [isLoading] is true, a loading indicator will be displayed instead of
  /// the text.
  const PrimaryButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.onPressed,
      this.style});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p192,
      height: Sizes.p64,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(Sizes.p12),
          color: Colors.black),
      child: TextButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(text, textAlign: TextAlign.center, style: style),
      ),
    );
  }
}
