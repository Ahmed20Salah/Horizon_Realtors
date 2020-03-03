import 'package:flutter/material.dart';
import 'package:horizon_realtors/pages/login_screen.dart';
import 'package:horizon_realtors/pages/user_home.dart';
import 'package:horizon_realtors/pages/user_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserHome(),
    );
  }
}
