import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    Key? key,
    this.enableOnTab = true,
  }) : super(key: key);

  final bool enableOnTab;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() {
    try {
      String? photoData = AuthenticationController.user?.photo;
      if (photoData != null && photoData.isNotEmpty) {
        imageBytes = const Base64Decoder().convert(photoData);
      } else {
        imageBytes = null;
      }
    } catch (e) {
      imageBytes = null;
    }
  }

  @override
  void didUpdateWidget(covariant ProfileSummaryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enableOnTab) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: imageBytes != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
          ),
        )
            : const Icon(Icons.person),
      ),
      title: Text(
        FullName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        AuthenticationController.user?.email ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthenticationController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
            );
          }
        },
        icon: const Icon(Icons.logout_outlined),
      ),
      tileColor: Colors.green,
    );
  }

  String get FullName {
    return '${AuthenticationController.user?.firstName ?? ""} ${AuthenticationController.user?.lastName ?? ""}';
  }
}
