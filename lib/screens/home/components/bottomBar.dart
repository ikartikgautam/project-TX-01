import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 60,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
              child: Icon(
            Icons.home,
            color: Colors.white,
            size: 28,
          )),
          Expanded(
              child: Icon(
            Icons.view_column,
            color: Colors.white,
            size: 28,
          )),
          Expanded(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 28,
          )),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
