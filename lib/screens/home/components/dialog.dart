import 'package:flutter/material.dart';
import 'package:musestar/screens/home/home.dart';
import 'package:musestar/screens/home/menus/camera.dart';

class BottomDialog extends StatefulWidget {
  @override
  _BottomDialogState createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  double _height = 200;
  Widget _modalIcon = Icon(Icons.expand_less, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.height;

    changeHeight() {
      setState(() {
        _height = deviceWidth;
        _modalIcon = Icon(
          Icons.expand_more,
          color: Colors.white,
        );
      });
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceOut,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      height: _height,
      child: Column(
        children: <Widget>[
          SizedBox(height: 6),
          IconButton(
              padding: EdgeInsets.all(0), icon: _modalIcon, onPressed: null),
          GestureDetector(
            onTap: () {
              print('Clicked');
              changeHeight();
            },
            child: Container(
              width: double.infinity,
              height: 40,
              child: Center(child: Text('What is in your mind ?')),
              margin: EdgeInsets.fromLTRB(24, 0, 24, 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: Colors.white),
            ),
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
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Camera()));
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
