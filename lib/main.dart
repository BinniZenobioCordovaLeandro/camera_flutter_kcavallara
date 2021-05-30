import 'package:flutter/material.dart';
import 'package:project_camera_flutter/pages/camera_page.dart';
import 'package:project_camera_flutter/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
      routes: {
        'home': (_) => HomePage(),
        'camera': (_) => CameraPage(),
      },
    );
  }
}
