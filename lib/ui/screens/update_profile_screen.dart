import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummaryCard(
            enableOnTab: false,
          ),
          Expanded(
            child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "First Name"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Last Name"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: "Mobile"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Update"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
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
              child: Container(
                child: Text("empty"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
