import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstnameTEController = TextEditingController();
  final TextEditingController _lastnameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    Text(
                      "Join With Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: "Email"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Valid email";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                        controller: _firstnameTEController,
                        decoration:
                            const InputDecoration(hintText: "First Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your First Name";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                        controller: _lastnameTEController,
                        decoration:
                            const InputDecoration(hintText: "Last Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Last Name";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: "Mobile"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Valid Mobile Number";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "Password"),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter your Valid Password";
                          }
                          if (value!.length < 8) {
                            return "Enter Password More than 8 Letters";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: signUp,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have Account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailTEController.text.trim(),
        "firstName": _firstnameTEController.text.trim(),
        "lastName": _lastnameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
      });
      _signUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(context, "Account has been Created! Please Log Inn");
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, "Account Creation Failed! Please try again", true);
        }
      }
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstnameTEController.clear();
    _lastnameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstnameTEController.dispose();
    _lastnameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
