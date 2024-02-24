import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteworthy/features/authentication/presentation/authentication_controller.dart';
import 'package:noteworthy/features/authentication/presentation/email_password_validators.dart';
import 'package:noteworthy/features/authentication/presentation/string_validators.dart';
import 'package:noteworthy/utils/async_value_ui.dart';
import 'package:noteworthy/common_widgets/custom_text_button.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/common_widgets/primary_button.dart';
import 'package:noteworthy/routing/app_router.dart';
import 'package:noteworthy/localization/string_hardcoded.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen>
    with EmailAndPasswordValidators {
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get username => _usernameController.text;

  var _submitted = false;

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (true) {
      final controller = ref.read(authenticationContorllerProvider.notifier);
      final success = await controller.signIn(email: email, password: password);
    }
  }

  // when pressing next on phone keyboard
  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  // when pressing enter after completing password
  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authenticationContorllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(authenticationContorllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapH128,
            const Text("Sign In",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.p32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500)),
            gapH32,
            FocusScope(
              node: _node,
              child: Column(
                children: <Widget>[
                  gapH8,
                  gapH8,
                  // Email field
                  Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(Sizes.p16),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(Sizes.p12, 0, 0, 0),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(Icons.person_2_outlined),
                            iconColor: Colors.black,
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black),
                            enabled: !state.isLoading,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.light,
                          onEditingComplete: () => _emailEditingComplete(),
                          inputFormatters: <TextInputFormatter>[
                            ValidatorInputFormatter(
                                editingValidator: EmailEditingRegexValidator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  gapH8,
                  // Password field
                  Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(Sizes.p16),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(Sizes.p12, 0, 0, 0),
                        child: TextField(
                          controller: _passwordController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),

                          decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: const Icon(Icons.password),
                              iconColor: Colors.black,
                              enabled: !state.isLoading,
                              labelStyle: const TextStyle(color: Colors.black),
                              labelText: "Password"),

                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (password) =>
                          //     !_submitted ? null : passwordErrorText(password ?? ''),
                          obscureText: true,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          keyboardAppearance: Brightness.light,
                          onEditingComplete: () => _passwordEditingComplete(),
                        ),
                      ),
                    ),
                  ),
                  gapH64,
                  PrimaryButton(
                    text: "Sign In".hardcoded,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.p20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400),
                    isLoading: state.isLoading,
                    onPressed: state.isLoading ? null : () => _submit(),
                  ),
                  gapH48,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?".hardcoded,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: "Poppins"),
                      ),
                      CustomTextButton(
                        text: "Sign Up".hardcoded,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.p20,
                            fontFamily: "Poppins"),
                        onPressed: () => context.goNamed(AppRoute.signUp.name),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
