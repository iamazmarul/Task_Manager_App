import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/login_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

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
                      "Get Started With",
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
                            return "Enter your Valid Email Address";
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
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Valid Password";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<LoginController>(
                          builder: (loginController) {
                        return Visibility(
                          visible: loginController.loginInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: userLogin,
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't Have an Account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignUpScreen());
                          },
                          child: const Text(
                            "Sign Up",
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

  Future<void> userLogin() async {
    if (_formKey.currentState!.validate()) {
      final response = await _loginController.userLogin(
          _emailTEController.text.trim(), _passwordTEController.text);
      if (response) {
        Get.offAll(const MainBottomNavbarScreen());
      } else {
        if (mounted) {
          showSnackMessage(context, _loginController.failedMessage);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
