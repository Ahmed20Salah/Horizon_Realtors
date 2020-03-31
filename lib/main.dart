import 'package:flutter/material.dart';
import 'package:horizon_realtors/pages/add_property.dart';
import 'package:horizon_realtors/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}
