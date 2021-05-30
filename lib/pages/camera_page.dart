import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
    this._requestPermission();
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

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    _toastInfo(info);
  }

  _toastInfo(String info) {
    ScaffoldMessenger.of(
      this.context,
    ).showSnackBar(
      SnackBar(
        content: Text(info.toString()),
      ),
    );
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
            xFile.saveTo(xFile.path);
            dynamic result = await ImageGallerySaver.saveFile(xFile.path);
            _toastInfo(result.toString());
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
