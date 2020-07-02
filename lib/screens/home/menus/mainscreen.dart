import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                child: Text('ONE'),
                color: Colors.blue,
              ),
              Container(
                child: Text('TWO'),
                color: Colors.red,
              ),
              Container(
                child: Text('THREE'),
                color: Colors.blue,
              ),
              Container(
                child: Text('FOUR'),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
