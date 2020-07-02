import 'package:flutter/material.dart';
import 'package:musestar/services/auth_service.dart';
import 'package:musestar/screens/home/components/bottomBar.dart';
import 'package:musestar/screens/home/menus/mainscreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Mainscreen(),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}

// Column(
//           children: <Widget>[
//             Text('Home'),
//             RaisedButton(
//               onPressed: () {
//                 _auth.SignOut();
//               },
//               child: Text('SIGN OUT'),
//             )
//           ],
//         ),
