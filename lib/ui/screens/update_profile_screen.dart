import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  final TextEditingController _firstNameTeController = TextEditingController();
  final TextEditingController _lastNameTeController = TextEditingController();
  final TextEditingController _mobileTeController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProfileScreenInProgress = false;
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTeController.text = AuthenticationController.user?.email ?? "";
    _firstNameTeController.text =
        AuthenticationController.user?.firstName ?? "";
    _lastNameTeController.text = AuthenticationController.user?.lastName ?? "";
    _mobileTeController.text = AuthenticationController.user?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileSummaryCard(
            enableOnTab: false,
          ),
          Expanded(
            child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        PhotoPicker(),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                            controller: _emailTeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(hintText: "Email"),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter your Valid email";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                            controller: _firstNameTeController,
                            decoration:
                                const InputDecoration(hintText: "First Name"),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter your Valid First Name";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                            controller: _lastNameTeController,
                            decoration:
                                const InputDecoration(hintText: "Last Name"),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "Enter your Valid Last Name";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                            controller: _mobileTeController,
                            keyboardType: TextInputType.phone,
                            decoration:
                                const InputDecoration(hintText: "Mobile"),
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
                          controller: _passwordTeController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: "Password"),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _updateProfileScreenInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                updateProfile();
                              },
                              child: const Text("Update"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _updateProfileScreenInProgress = true;
      if (mounted) {
        setState(() {});
      }
      String? photoInBase64;
      Map<String, dynamic> inputData = {
        "email": _emailTeController.text.trim(),
        "firstName": _firstNameTeController.text.trim(),
        "lastName": _lastNameTeController.text.trim(),
        "mobile": _mobileTeController.text.trim(),
      };

      if (_passwordTeController.text.isNotEmpty) {
        inputData["password"] = _passwordTeController.text;
      }

      if (photo != null) {
        List<int> imageBytes = await photo!.readAsBytes();
        String photoInBase64 = base64Encode(imageBytes);
        inputData["photo"] = photoInBase64;
      }

      final NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.updateProfile, body: inputData);
      _updateProfileScreenInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        AuthenticationController.updateUserInfo(
          UserModel(
            email: _emailTeController.text.trim(),
            firstName: _firstNameTeController.text.trim(),
            lastName: _lastNameTeController.text.trim(),
            mobile: _mobileTeController.text.trim(),
              photo: photoInBase64 ?? AuthenticationController.user?.photo
          ),
        );
        if (mounted) {
          showSnackMessage(context, "Profile Update Success");
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Profile Update failed! Please Try Again");
        }
      }
    }
  }

  Container PhotoPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Photo",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.camera, imageQuality: 50);
                  if (image != null) {
                    photo = image;
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  child: Visibility(
                      visible: photo == null,
                      replacement: Text(photo?.name ?? ""),
                      child: const Text("Select a photo")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
