import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musestar/screens/home/menus/preview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Camera extends StatefulWidget {
  // Camera({key:key}):
  @override
  _CameraState createState() => _CameraState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String videoPath;
bool pauseFlag = false;
Timer _timer;
int _start = 20;
Color shutterColor = Colors.white;

void pauseTimer() {}

class _CameraState extends State<Camera> {
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
    CameraService _camS = CameraService();
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
                // Top Progress Bar of recording
                Positioned(
                    top: 0,
                    child: AnimatedContainer(
                      height: 8,
                      duration: Duration(milliseconds: 1000),
                      width: ((20 - _start) / 20) * deviceWidth,
                      color: Colors.red,
                    )),
                // Other UI elements of camera
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
                      onPressed: () {
                        setState(() {
                          getCamera().then((camera) => {});
                        });
                      }),
                  top: 0,
                  right: 0,
                ),
                Positioned(
                  child: Container(
                    width: deviceWidth,
                    height: 120,
                    child: Row(
                      children: <Widget>[
                        // This is a null Button right now
                        Expanded(
                          child: IconButton(
                              icon: Icon(Icons.ac_unit, color: Colors.white),
                              onPressed: () {}),
                        ),
                        // This is Recording Button to start/Pause Recording
                        Expanded(
                          child: GestureDetector(
                            onLongPress: () {
                              // Implement play recording
                              _controller != null &&
                                      _controller.value.isInitialized
                                  ? _camS.startRec(_scaffoldKey, _controller)
                                  : null;

                              const oneSec = const Duration(seconds: 1);
                              _timer =
                                  new Timer.periodic(oneSec, (Timer timer) {
                                print(_start);
                                setState(() {
                                  _start = _start - 1;
                                });
                              });
                              setState(() {
                                shutterColor = Colors.grey;
                              });
                            },
                            onLongPressUp: () {
                              // Implement pause recording
                              setState(() {
                                shutterColor = Colors.white;
                              });

                              _controller != null &&
                                      _controller.value.isInitialized &&
                                      _controller.value.isRecordingVideo
                                  ? _camS.pauseRec(_scaffoldKey, _controller)
                                  : null;
                            },
                            child: IconButton(
                              icon: Icon(Icons.lens, size: 70),
                              onPressed: () {
                                _camS.showSnackBar(_scaffoldKey,
                                    'Long Press the record button to start recording');
                              },
                              color: shutterColor,
                            ),
                          ),
                        ),
                        // This is a stop recording button
                        Expanded(
                          child: IconButton(
                              icon: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // implement stop record and show preview
                                _camS.stopRec(_scaffoldKey, _controller);
                                Navigator.push(
                                    context,
                                    new CupertinoPageRoute(
                                        builder: (context) => VideoPlayerScreen(
                                            path: videoPath)));
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

class CameraService {
  _CameraState camState = _CameraState();
// show snackbar/Toast (NEWER VERSIONS SHOW TOAST)
  showSnackBar(_key, _msg) {
    FlutterToast.showToast(
        msg: _msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP);
  }

  // start Reccording
  startRec(_key, controller) {
    print(pauseFlag);
    if (pauseFlag == false) {
      pauseFlag = true;
      _startVideoRecording(_key, controller).then((String filePath) {
        if (filePath != null) {
          showSnackBar(_key, 'Recording Started');
        }
      });
    } else {
      // print(controller.value);
      // controller.resumeVideoRecording();
      // showSnackBar(_key, 'Resumed');
      _resumeVideoRecording(_key, controller).then((value) => {
            if (value != null) {showSnackBar(_key, 'Resumed Video')}
          });
    }
  }

  // stop Recording
  void stopRec(_key, controller) {
    _stopVideoRecording(_key, controller).then((_) {
      showSnackBar(_key, 'Video recording saved to  $videoPath');
    });
  }

  void pauseRec(_key, controller) {
    _pauseVideoRecording(_key, controller).then((_) {
      showSnackBar(_key, 'Paused Video');
    });
  }

  // functions
  Future<String> _startVideoRecording(_key, controller) async {
    if (!controller.value.isInitialized) {
      showSnackBar(_key, 'Please Wait');
      return null;
    }
    if (controller.value.isRecordingVideo) {
      showSnackBar(_key, 'Already Recording');
      return null;
    }

    final Directory appDirectory = await getExternalStorageDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '${videoDirectory}/${currentTime}.mp4';

    try {
      await controller.startVideoRecording(filePath);
      videoPath = filePath;
    } on CameraException catch (e) {
      showSnackBar(_key, e);
      return null;
    }
    return filePath;

    // await controller.resumeVideoRecording();
    // showSnackBar(_key, 'Resumed');
  }

  Future<String> _stopVideoRecording(_key, controller) async {
    if (!controller.value.isRecordingVideo) {
      showSnackBar(_key, 'Not Recording Yet');
      return null;
    }
    try {
      await controller.stopVideoRecording();
      _timer.cancel();
      pauseFlag = false;
    } on CameraException catch (e) {
      showSnackBar(_key, e);
      return null;
    }
  }

  Future<String> _resumeVideoRecording(_key, controller) async {
    if (controller.value.isRecordingVideo) {
      try {
        controller.resumeVideoRecording();
      } on CameraException catch (e) {
        showSnackBar(_key, e);
        return null;
      }
    } else {
      return null;
    }
    return 'Works';
  }

  Future<String> _pauseVideoRecording(_key, controller) async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }
    try {
      await controller.pauseVideoRecording();
      _timer.cancel();
    } on CameraException catch (e) {
      showSnackBar(_key, e);
      return null;
    }
  }
}
