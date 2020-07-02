import 'package:flutter/material.dart';

class BottomDialog extends StatefulWidget {
  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      height: 200,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 34,
            child: Center(child: Text('What is in your mind ?')),
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: Center(child: Text('Suggestions')),
            margin: EdgeInsets.fromLTRB(24, 6, 24, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
          )
        ],
      ),
    );
  }
}
