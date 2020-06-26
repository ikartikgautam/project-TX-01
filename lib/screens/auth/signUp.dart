import 'package:flutter/material.dart';
import 'package:musestar/screens/auth/signUpForms/createUser.dart';
import 'package:musestar/screens/auth/signUpForms/signUpDetails.dart';

class SignUp extends StatefulWidget {
  final Function toggleForm;

  SignUp({this.toggleForm});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool form = true;
  String newEmail,newPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: getView(),
        ),
      ),
    );
  }

  Widget getView() {
    if (form) {
      return CreateUser(toggleForm: widget.toggleForm,toggleSUPForm: toggleSUPForm);
    } else {
      return SignUpDetail(toggleForm: widget.toggleForm,email:newEmail,pass:newPass);
    }
  }

  void toggleSUPForm(String email,String pass) {
    setState(() {
      newEmail = email;
      newPass = pass;
      form = !form;
    });
  }
}
