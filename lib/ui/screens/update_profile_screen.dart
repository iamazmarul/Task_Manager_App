import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';
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
  final UpdateProfileController _updateProfileController =
  Get.find<UpdateProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTeController.text =
        Get.find<AuthenticationController>().user?.email ?? "";
    _firstNameTeController.text =
        Get.find<AuthenticationController>().user?.firstName ?? "";
    _lastNameTeController.text =
        Get.find<AuthenticationController>().user?.lastName ?? "";
    _mobileTeController.text =
        Get.find<AuthenticationController>().user?.mobile ?? "";
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
                          photoPicker(),
                          const SizedBox(
                            height: 8,
                          ),
                          // ... Existing code ...
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
                            child: GetBuilder<UpdateProfileController>(
                                builder: (updateProfileController) {
                                  return Visibility(
                                    visible: _updateProfileController
                                        .updateProfileScreenInProgress ==
                                        false,
                                    replacement: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        updateProfile();
                                      },
                                      child: const Text("Update"),
                                    ),
                                  );
                                }),
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
      ),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final response = await _updateProfileController.updateProfile(
        _emailTeController.text.trim(),
        _firstNameTeController.text.trim(),
        _lastNameTeController.text.trim(),
        _mobileTeController.text.trim(),
        _passwordTeController.text,
      );

      if (response) {
        if (mounted) {
          showSnackMessage(context, "Profile Update Success");
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, "Profile Update failed! Please Try Again");
        }
      }
    }
  }

  Container photoPicker() {
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
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.camera, imageQuality: 50);
                if (image != null) {
                  _updateProfileController.photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: _updateProfileController.photo != null,
                  replacement: Text(_updateProfileController.photo?.name ?? ""),
                  child: _updateProfileController.photo != null
                      ? Image.file(
                    File(_updateProfileController.photo!.path),
                    height: 100,
                    width: 40,
                    fit: BoxFit.cover,
                  )
                      : const Text("Select a photo"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
