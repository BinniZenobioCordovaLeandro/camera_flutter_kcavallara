import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text('Go Camera'),
            onPressed: () {
              Navigator.of(context).pushNamed('camera');
            },
          ),
        ),
      ),
    );
  }
}
