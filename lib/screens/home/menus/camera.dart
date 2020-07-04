import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:musestar/services/camCorder.dart';
import 'package:path/path.dart';

class Camera extends StatefulWidget {
  // Camera({key:key}):
  @override
  _CameraState createState() => _CameraState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _CameraState extends State<Camera> {

  CamCordService _cam = CamCordService();
  CameraController _controller;
  Future<void> _controllerInializer;

  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
  }

  @override
  void initState() {
    super.initState();
    getCamera().then((camera) => {
          setState(() {
            _controller = CameraController(camera, ResolutionPreset.high);
            _controllerInializer = _controller.initialize();
          })
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _controllerInializer,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
                child: Stack(
              children: <Widget>[
                CameraPreview(_controller),
                Positioned(
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  top: 0,
                  left: 0,
                ),
                Positioned(
                  child: IconButton(
                      icon: Icon(Icons.camera_front),
                      color: Colors.white,
                      onPressed: () {}),
                  top: 0,
                  right: 0,
                ),
                Positioned(
                  child: Container(
                    width: deviceWidth,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                              icon: Icon(Icons.ac_unit), onPressed: null),
                        ),
                        Expanded(
                          child: GestureDetector(
                            // onLongPress: () {
                            //   _cam.StartRecord(_controller,_scaffoldKey);
                            // },
                            // onLongPressUp: () {
                            //   _cam.PauseRecord(_controller,_scaffoldKey);
                            // },
                            child: IconButton(
                              icon: Icon(Icons.lens, size: 60),
                              onPressed: () {
                                _cam.StartRecord(_controller,_scaffoldKey);
                              },
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                              icon: Icon(Icons.done),
                              onPressed: () {
                                _cam.StopRecord(_controller,_scaffoldKey);
                              }),
                        ),
                      ],
                    ),
                  ),
                  bottom: 0,
                )
              ],
            )),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
