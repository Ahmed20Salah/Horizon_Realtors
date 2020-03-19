import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/pages/user_type.dart';
import 'package:horizon_realtors/widget/logo.dart';

import '../blocs/user_bloc/user_bloc.dart';
import '../models/user.dart';
import '../repository/user_repo.dart';
import 'home.dart';
import 'user_home.dart';

class RegisterPage extends StatefulWidget {
  final UserType type;
  RegisterPage({this.type});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _bloc = UserBloc();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
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
              Logo(true),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.type == null
                            ? 'Create account'
                            : widget.type == UserType.Agency
                                ? 'Create account as an agency'
                                : 'Create account as an agent',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _name,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'please enter a valid Name';
                          }
                        },
                        decoration: _inputDecoration(
                            widget.type == UserType.Agency
                                ? 'Agency name'
                                : 'Name'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _email,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'please enter a valid email';
                          }
                        },
                        decoration: _inputDecoration(
                            widget.type == UserType.Agency
                                ? 'Agency e-mail address'
                                : 'Email'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _phone,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'please enter a valid Phone';
                          }
                        },
                        decoration: _inputDecoration(
                            widget.type == UserType.Agency
                                ? 'Agency phone number'
                                : 'Phone'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _pass,
                        obscureText: true,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'please enter a valid password';
                          }
                        },
                        decoration: _inputDecoration('Password'),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      _loginButton(context),
                      widget.type != null
                          ? Container()
                          : Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  top: 20.0, bottom: 16.0),
                              child: Text(
                                'Are you an agent or an agency?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                      widget.type != null ? Container() : _createButton(),
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

  _inputDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      fillColor: Colors.white.withOpacity(.24),
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white),
      border: _inputBorder(),
      errorStyle: TextStyle(color: Color(0xffFF9292)),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.white),
    );
  }

  Widget _loginButton(context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          widget.type == null
              ? 'Create account'
              : widget.type == UserType.Agency ? 'Submit' : 'Countine',
          style: TextStyle(
              color: Color(0xff6178B9),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        _formkey.currentState.save();
        print(_formkey.currentState.validate());
        if (_formkey.currentState.validate()) {
          print(widget.type);
          Map _data = {
            'name': _name.text,
            'email': _email.text,
            'phone': _phone.text,
            'password': _pass.text,
            'role': widget.type == UserType.Agency
                ? '2'
                : widget.type == UserType.Agent ? "3" : "1"
          };
          widget.type == UserType.Agent
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserTypeScreen(data: _data)))
              : _bloc.add(Register(_data));
        }
      },
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
          return showBottomSheet(
            context: context,
            builder: (context) => Container(
              alignment: Alignment.center,
              height: 30.0,
              child: Text(state.error['errors']),
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

  Widget _createButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white, width: 2)),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Create corporate account',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserTypeScreen()));
      },
    );
  }
}
