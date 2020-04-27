import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/pages/add_property.dart';
import 'package:horizon_realtors/pages/agency_screen.dart';
import 'package:horizon_realtors/pages/chat_room.dart';
import 'package:horizon_realtors/pages/splash.dart';

import 'blocs/agency_bloc/agency_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(),
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
