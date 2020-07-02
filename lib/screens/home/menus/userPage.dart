import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(Icons.sentiment_satisfied, size: 70),
                ),
                SizedBox(height:12),
                Text('UserName Lastname')
              ],
            ),
          )
        ],
      ),
    );
  }
}
