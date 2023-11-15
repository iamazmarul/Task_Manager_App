import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key, this.enableOnTab = true,
  });
final bool enableOnTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if(enableOnTab)
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: const Text(
        "Azmarul Islam",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: const Text(
        "iamazmarul@gmail.com",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.logout_outlined),
      ),
      tileColor: Colors.green,
    );
  }
}
