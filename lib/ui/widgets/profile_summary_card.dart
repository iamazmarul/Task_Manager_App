import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    Key? key,
    this.enableOnTab = true,
  }) : super(key: key);

  final bool enableOnTab;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (authenticationController) {
        Uint8List? imageBytes;
        try {
          String? photoData = authenticationController.user?.photo;
          if (photoData != null && photoData.isNotEmpty) {
            imageBytes = const Base64Decoder().convert(photoData);
          }
        } catch (e) {
          imageBytes = null;
        }

        return ListTile(
          onTap: () {
            if (enableOnTab) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ),
              );
            }
          },
          leading: CircleAvatar(
            child: Get.find<AuthenticationController>().user?.photo == null
                ? const Icon(Icons.person)
                : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.memory(
                imageBytes ?? Uint8List(0), // Use a default value if imageBytes is null
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            fullName(authenticationController),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            authenticationController.user?.email ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              await AuthenticationController.clearAuthData();
              Get.offAll(const LoginScreen());
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          tileColor: Colors.green,
        );
      },
    );
  }

  String fullName(AuthenticationController authenticationController) {
    return '${authenticationController.user?.firstName ?? ""} ${authenticationController.user?.lastName ?? ""}';
  }
}
