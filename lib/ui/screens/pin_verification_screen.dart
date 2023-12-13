import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/controllers/pin_verification_controller.dart';
import 'package:task_manager/ui/screens/set_password_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      "PIN Verification",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      "A 6 digit verification pin will send to your \n email address",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GetBuilder<PinVerificationController>(
                      builder: (PinVerificationController) {
                        return PinCodeTextField(
                            controller: _otpTEController,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              activeColor: Colors.green,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            onCompleted: (value) {PinVerificationController.sendForgotPasswordRequest(_otpTEController.text)
                                .then((value) {
                              if (value) {
                                if (mounted) {
                                  showSnackMessage(context, "Success OTP Verified");
                                }
                                Get.to(const SetPasswordScreen());
                              } else {
                                if (mounted) {
                                  showSnackMessage(context, "Failed Wrong OTP");
                                }
                              }
                            });},
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                            );
                      }
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<PinVerificationController>(
                          builder: (PinVerificationController) {
                        return Visibility(
                          visible: PinVerificationController
                                  .pinVerificationInProgress ==
                              false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              PinVerificationController.sendForgotPasswordRequest(_otpTEController.text)
                                  .then((value) {
                                if (value) {
                                  if (mounted) {
                                    showSnackMessage(context, "Success OTP Verified");
                                  }
                                  _clearTextFields();
                                  Get.to(const SetPasswordScreen());
                                } else {
                                  if (mounted) {
                                    showSnackMessage(context, "Failed Wrong OTP");
                                  }
                                }
                              });
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 32.0,
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
                            Get.offAll(const LoginScreen());
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


  void _clearTextFields() {
    _otpTEController.clear();
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
