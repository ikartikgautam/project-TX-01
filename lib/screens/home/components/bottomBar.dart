import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musestar/screens/home/components/dialog.dart';

class Bottombar extends StatefulWidget {

final Function changeView;

Bottombar({this.changeView});

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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                  child: CupertinoButton(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  widget.changeView('home');
                },
                padding: EdgeInsets.all(0),
              )),
              Expanded(
                child: CupertinoButton(
                    child: Icon(
                      Icons.view_column,
                      color: Colors.white,
                      size: 28,
                    ),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      _openDialog(context);
                    }),
              ),
              Expanded(
                child: CupertinoButton(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    widget.changeView('user');
                  },
                  padding: EdgeInsets.all(0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDialog(context) {
    print(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BottomDialog();
        });
  }
}
