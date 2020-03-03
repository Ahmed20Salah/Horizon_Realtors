import 'package:flutter/material.dart';
import 'package:horizon_realtors/widget/logo.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
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
                          'Create account',
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
                              'Name', 'please enter a valid Name'),
                        ),
                         SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                              'Email', 'please enter a valid email'),
                        ),
                          SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                              'Phone', 'please enter a valid Phone'),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _inputDecoration(
                              'Password', 'please enter a valid password'),
                        ),
                        SizedBox(height: 16.0,),
                        _loginButton(),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Text(
                            'Are you an agent or an agency?',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        _createButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
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

  Widget _loginButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Create account',
          style: TextStyle(
              color: Color(0xff6178B9),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _createButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white ,width: 2)),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Create corporate account',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
