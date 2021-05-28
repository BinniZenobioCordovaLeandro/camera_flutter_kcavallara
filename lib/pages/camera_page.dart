import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with SingleTickerProviderStateMixin {
  List<CameraDescription> cameras = List<CameraDescription>.empty();
  CameraController controller = CameraController(
      new CameraDescription(
          lensDirection: CameraLensDirection.back,
          name: 'back',
          sensorOrientation: 1),
      ResolutionPreset.max);

  @override
  void initState() {
    super.initState();
    this.initialize();
  }

  void initialize() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          try {
            final XFile xFile = await controller.takePicture();
            getApplicationDocumentsDirectory().then((directory) async {
              print('xFile.saveTo(${directory.path}/${xFile.name})');
              await xFile.saveTo('${directory.path}/${xFile.name}');
              ScaffoldMessenger.of(
                this.context,
              ).showSnackBar(
                SnackBar(
                  content: Text('Image saved ${directory.path}/${xFile.name})'),
                ),
              );
            });
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CameraPreview(controller),
    );
  }
}
