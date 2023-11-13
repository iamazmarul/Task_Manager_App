import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBackground(
        child: Center(
          child: SvgPicture.asset(
            "assets/images/app-logo.svg",
            width: 120,
          ),
        ),
      ),
    );
  }
}
