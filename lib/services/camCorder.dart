import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class CamCordService {
  var logger = Logger();

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  String fileP;

  StartRecord(controller, scaffoldKey) async {
    logger.w("START");
    try {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Movies/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${timestamp()}.mp4';
      fileP = filePath;
      await controller.startVideoRecording(filePath);
    } catch (err) {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(err)));
    }
  }

  PauseRecord(controller, scaffoldKey) async {
    try {
      logger.w("PAUSE");
      await controller.pauseVideoRecording();
    } catch (err) {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(err)));
    }
  }

  StopRecord(controller, scaffoldKey) {
    controller.stopVideoRecording();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(fileP)));
  }
}
