import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/blocs/user_bloc/user_bloc.dart';
import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/pages/home.dart';
import 'package:horizon_realtors/pages/login_screen.dart';
import 'package:horizon_realtors/pages/user_home.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/widget/logo.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _userRepository = UserRepository();
  final _bloc = UserBloc();
  final _chatBloc = ChatBloc();
  @override
  void initState() {
    _bloc.add(Checking());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff3FB1E3),
              Color(0xff6178B9),
            ],
            begin: Alignment(0, 0),
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Logo(false),
            _listen(),
          ],
        ),
      ),
    );
  }

  BlocListener<UserBloc, UserState> _listen() {
    return BlocListener<UserBloc, UserState>(
      bloc: _bloc,
      listener: (context, state) {
        print(state);
        if (state is Authenticated) {
_chatBloc.add(GetAllChats(BlocProvider.of<ChatBloc>(context)));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  _userRepository.user.type == UserType.EndUser
                      ? UserHome()
                      : Home(),
            ),
          );
        } else if (state is Unauthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
