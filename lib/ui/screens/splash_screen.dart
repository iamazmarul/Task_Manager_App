import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
