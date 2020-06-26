import 'package:flutter/material.dart';
import 'package:musestar/screens/auth/signIn.dart';
import 'package:musestar/screens/auth/signUp.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool inView = false;

  void toggleForm() {
    setState(() {
      inView = !inView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!inView) {
      return SignIn(toggleForm: toggleForm);
    } else {
      return SignUp(toggleForm: toggleForm);
    }
  }
}
