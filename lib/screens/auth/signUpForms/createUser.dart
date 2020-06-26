import 'package:flutter/material.dart';
import 'package:musestar/services/auth_service.dart';

class CreateUser extends StatefulWidget {
  final Function toggleForm;
  final Function toggleSUPForm;

  CreateUser({this.toggleForm, this.toggleSUPForm});

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  AuthService _auth = AuthService();

  String email, pass;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Email', helperText: 'Enter your Email ID'),
                  ),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        pass = val;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        helperText: 'Enter your Password'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          FloatingActionButton(
            onPressed: () async {
              widget.toggleSUPForm(email,pass);
            },
            child: Icon(Icons.keyboard_arrow_right),
            backgroundColor: Colors.black,
          ),
          FlatButton(
            onPressed: () {
              widget.toggleForm();
            },
            child: Text('Have an account already?'),
          ),
        ],
      ),
    );
  }
}
