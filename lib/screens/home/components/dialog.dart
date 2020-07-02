import 'package:flutter/material.dart';

class BottomDialog extends StatefulWidget {
  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      height: 400,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 40,
            child: Center(child: Text('What is in your mind ?')),
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(24, 6, 24, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.send,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: null))),
                  Expanded(
                      child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }))),
                  Expanded(
                      child: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.ac_unit,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: null))),
                ],
              ))
        ],
      ),
    );
  }
}
