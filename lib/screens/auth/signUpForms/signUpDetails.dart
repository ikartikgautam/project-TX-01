import 'package:flutter/material.dart';
import 'package:musestar/models/user.dart';
import 'package:musestar/services/auth_service.dart';
import 'package:musestar/services/rds_server_service.dart';

class SignUpDetail extends StatefulWidget {
  final Function toggleForm;
  String email, pass;
  SignUpDetail({this.toggleForm, this.email, this.pass});

  @override
  _SignUpDetailState createState() => _SignUpDetailState();
}

class _SignUpDetailState extends State<SignUpDetail> {
  AuthService _auth = AuthService();
  RdsServerService _rds = RdsServerService();

  String museId, name, phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      museId = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Muse ID', helperText: 'Enter your Muse ID'),
                ),
                TextFormField(
                  onChanged: (val) => {setState(() => name = val)},
                  decoration: InputDecoration(
                      labelText: 'Name', helperText: 'Enter your Full Name'),
                ),
                TextFormField(
                  onChanged: (val) => {setState(() => phone = val)},
                  decoration: InputDecoration(
                      labelText: 'Contact',
                      helperText: 'Enter your phone number'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () async {
              UserDetailsModel _detailsModel = UserDetailsModel(
                  uid: 'testUid',
                  profileId: 'museID',
                  userName: name,
                  email: widget.email,
                  phone: '2123123');

              String response = await _auth.SignUpEmailPass(
                  widget.email, widget.pass, museId, name, phone);
            },
            child: Icon(Icons.done),
          ),
          // SizedBox(height: 30),
          FlatButton(
              onPressed: () {
                widget.toggleForm();
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }
}
