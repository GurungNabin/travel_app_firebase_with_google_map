import 'package:flutter/material.dart';
import 'package:travel_guide_app/auth/auth_screen/login_screen.dart';
import 'package:travel_guide_app/auth/auth_screen/register_screen.dart';

class LogInOrRegisterPage extends StatefulWidget {
  const LogInOrRegisterPage({super.key});

  @override
  State<LogInOrRegisterPage> createState() => _LogInOrRegisterPageState();
}

class _LogInOrRegisterPageState extends State<LogInOrRegisterPage> {
//initially show login page
  bool showLogInPage = true;

//toogle between login and register page
  void tooglePages() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LogInScreen(
        onTap: tooglePages,
      );
    } else {
      return RegisterScreen(
        onTap: tooglePages,
      );
    }
  }
}
