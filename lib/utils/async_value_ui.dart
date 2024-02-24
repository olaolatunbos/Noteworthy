import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteworthy/common_widgets/alert_dialogs.dart';
import 'package:noteworthy/exceptions/app_exceptions.dart';

/// A helper [AsyncValue] extension to show an alert dialog on error
extension AsyncValueUI on AsyncValue {
  /// show an alert dialog if the current [AsyncValue] has an error and the
  /// state is not loading.
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: 'Error',
        exception: message,
      );
    }
  }

  /// get error message
  String _errorMessage(Object? error) {
    if (error is FirebaseAuthException) {
      return error.message ?? error.toString();
    } else if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}
