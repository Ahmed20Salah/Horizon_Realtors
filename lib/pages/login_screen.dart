

import 'package:flutter/material.dart';
import 'package:horizon_realtors/pages/register.dart';
import 'package:horizon_realtors/widget/logo.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

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
                        style: TextStyle(color: Colors.white),
                        decoration: _inputDecoration(
                            'Email', 'please enter a valid email'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: _inputDecoration(
                            'Password', 'please enter a valid password'),
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

  _inputDecoration(String hint, String error) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
           fillColor: Colors.white.withOpacity(.24),

      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white),
      border: InputBorder.none,
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
          'Login',
          style: TextStyle(
              color: Color(0xff6178B9),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        
      },
    );
  }

  Widget _createButton(context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white , width: 2)),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Create account',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register(),
          ),
        );
      },
    );
  }
}
