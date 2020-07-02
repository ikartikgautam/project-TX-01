import 'package:flutter/material.dart';
import 'package:musestar/screens/home/menus/userPage.dart';
import 'package:musestar/services/auth_service.dart';
import 'package:musestar/screens/home/components/bottomBar.dart';
import 'package:musestar/screens/home/menus/mainscreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String page = 'home';

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getView(),
      ),
      bottomNavigationBar: Bottombar(changeView: changeView),
    );
  }

  changeView(clicked) {
    if (clicked == 'home') {
      setState(() {
        page = 'home';
      });
    } else if (clicked == 'user') {
      setState(() {
        page = 'user';
      });
    }
  }

  getView() {
    if (page == 'home')
      return Mainscreen();
    else if (page == 'user') return UserPage();
  }
}
