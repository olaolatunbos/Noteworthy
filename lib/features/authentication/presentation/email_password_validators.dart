import 'package:noteworthy/features/authentication/presentation/string_validators.dart';
import 'package:noteworthy/localization/string_hardcoded.dart';

/// Mixin class to be used for client-side email & password validation
mixin EmailAndPasswordValidators {
  // check email is valid
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  // check password has at least 8 characters
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  // ensures password is not empty
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    return passwordRegisterSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty
        ? 'Email can\'t be empty'.hardcoded
        : 'Invalid email'.hardcoded;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText = password.isEmpty
        ? 'Password can\'t be empty'.hardcoded
        : 'Password is too short'.hardcoded;
    return showErrorText ? errorText : null;
  }
}
