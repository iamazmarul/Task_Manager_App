import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _newConPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _setNewPasswordVerificationInProgress = false;

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
                      "Set Password",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      "Minimum length password 8 character with \n Letter and Number combination",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _newPasswordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "Password"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Valid Password";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _newConPasswordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "Confirm Password"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Valid Confirm Password";
                          }
                          return null;
                        }
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _setNewPasswordVerificationInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setNewPassword();
                          },
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
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                                    (route) => false
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> setNewPassword() async {
    if (_formKey.currentState!.validate()) {
      _setNewPasswordVerificationInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final saveEmail = await AuthenticationController.callEmail();
      final saveOtp = await AuthenticationController.callOTP();

      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.setNewPassword, body: {
        "email":saveEmail,
        "OTP":saveOtp,
        "password":_newPasswordTEController.text,

      });
      _setNewPasswordVerificationInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        _clearTextFields();
        if(mounted) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
        }
        if (mounted) {
          showSnackMessage(context, "Forgot Password Successfully ");
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, "Forgot Password Failed! Please try again", true);
        }
      }
    }
  }

  void _clearTextFields() {
    _newPasswordTEController.clear();
    _newConPasswordTEController.clear();
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _newConPasswordTEController.dispose();
    super.dispose();
  }
}
