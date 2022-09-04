import 'package:amazone_clone/common/widgets/custom_button.dart';
import 'package:amazone_clone/common/widgets/custom_textfield.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final signUpFromKey = GlobalKey<FormState>();
  final signInFromKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        email: _emailController.text,
        context: context,
        name: _nameController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signInUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            radioButton(
              "Create account.",
              Auth.signup,
              _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
            ),
            _auth == Auth.signup
                ? Container(
                    padding: const EdgeInsets.all(08),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: signUpFromKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                hintLabel: "Email",
                                controller: _emailController),
                            kSizedBoxAuthFormField,
                            CustomTextField(
                                hintLabel: "Name", controller: _nameController),
                            kSizedBoxAuthFormField,
                            CustomTextField(
                                hintLabel: "Password",
                                controller: _passwordController),
                            kSizedBoxAuthFormField,
                            CustomButton(
                                onPressed: () {
                                  if (signUpFromKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                                text: "Sign  Up")
                          ],
                        )),
                  )
                : Container(
                    padding: const EdgeInsets.all(08),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: signInFromKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                hintLabel: "Email",
                                controller: _emailController),
                            kSizedBoxAuthFormField,
                            CustomTextField(
                                hintLabel: "Password",
                                controller: _passwordController),
                            kSizedBoxAuthFormField,
                            CustomButton(
                                onPressed: () {
                                  if (signInFromKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                                text: "Sign  In")
                          ],
                        )),
                  ),
            radioButton(
              "Sign-In",
              Auth.signin,
              _auth == Auth.signup
                  ? GlobalVariables.greyBackgroundCOlor
                  : GlobalVariables.backgroundColor,
            ),
          ],
        ),
      )),
    );
  }

  ListTile radioButton(String label, Auth value, Color tileClr) {
    return ListTile(
      tileColor: tileClr,
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: Radio(
          activeColor: GlobalVariables.secondaryColor,
          value: value,
          groupValue: _auth,
          onChanged: (Auth? val) {
            setState(() {
              _auth = val!;
            });
          }),
    );
  }
}

const kSizedBoxAuthFormField = SizedBox(height: 10);
