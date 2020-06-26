import 'package:flutter/material.dart';
import 'package:musestar/screens/auth/auth.dart';
import 'package:musestar/services/auth_service.dart';

class SignIn extends StatefulWidget {
  final Function toggleForm;

  SignIn({this.toggleForm});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String msg = 'Msg here';
  String email, pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Image.asset(
                'assets/museLogo.png',
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) {
                        email = val;
                      },
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      onChanged: (val) {
                        pass = val;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _auth.SignInEmailPass(email, pass);
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
            FlatButton(
                onPressed: () {
                  widget.toggleForm();
                },
                child: Text('Dont have an account ?'))
          ],
        ),
      ),
    );
  }
}
