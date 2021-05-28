import 'package:flutter/material.dart';
import 'package:project_camera_flutter/pages/camera_page.dart';

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
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('es', 'ES'), // Español
        const Locale('it', 'IT'), // Italiano
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: CameraPage(),
    );
  }
}
