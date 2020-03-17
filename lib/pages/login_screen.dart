import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/widget/logo.dart';

import '../blocs/user_bloc/user_bloc.dart';
import '../models/user.dart';
import '../repository/user_repo.dart';
import 'home.dart';
import 'register.dart';
import 'user_home.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _bloc = UserBloc();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _userRepository = UserRepository();
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Logo(false),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _email,
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val.isEmpty ||
                              !val.contains('@') ||
                              val.length < 2) {
                            return 'please enter a valid email';
                          }
                        },
                        decoration: _inputDecoration('Email'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _pass,
                        validator: (val) {
                          if (val.isEmpty ||
                              val.length < 5 ||
                              val.contains(' ')) {
                            return 'please enter a valid password';
                          }
                        },
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                        child: InkWell(
                          child: Text(
                            'Recover Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      _loginButton(context),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 44.0, bottom: 16.0),
                        child: Text(
                          'Dont have an account yet?',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      _createButton(context),
                      _listen()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BlocListener<UserBloc, dynamic> _listen() {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Loading) {
          return showDialog(
            context: context,
            child: AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else if (state is Error) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Container(
                alignment: Alignment.center,
                height: 20.0,
                child: Text(state.error['error']),
              ),
            ),
          );
        } else if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  _userRepository.user.type == UserType.EndUser
                      ? UserHome()
                      : Home(),
            ),
          );
        }
        return Container();
      },
      child: Container(),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        fillColor: Colors.white.withOpacity(.24),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        border: _inputBorder(),
        errorStyle: TextStyle(color: Color(0xffFCE187)),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color(0xffFF9292)),
        ));
  }

  _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.white),
    );
  }

  Widget _loginButton(context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            height: 48.0,
            alignment: Alignment.center,
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff6178B9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            _formkey.currentState.save();
            if (_formkey.currentState.validate()) {
              _bloc.add(Login({'email': _email.text, 'password': _pass.text}));
            }
          },
        );
      },
    );
  }

  Widget _createButton(context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white, width: 2)),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Create account',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
    );
  }
}
