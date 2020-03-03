import 'package:flutter/material.dart';
import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/widget/logo.dart';

class UserTypeScreen extends StatefulWidget {
  @override
  _UserType createState() => _UserType();
}

class _UserType extends State<UserTypeScreen> {
  UserType type;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'What better describes you?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 24,
                              width: 24,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 1.25),
                              ),
                              child: type == UserType.Agent
                                  ? Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                    )
                                  : Container(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'I`m an agent',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            type = UserType.Agent;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      InkWell(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 24,
                              width: 24,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 1.25),
                              ),
                              child: type == UserType.Agency
                                  ? Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                    )
                                  : Container(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'I`m an agent',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            type = UserType.Agency;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      _continueButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: type == null ? Color(0xffEEF5F8) : Colors.white,
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          'Continue',
          style: TextStyle(
              color: Color(0xff6178B9),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
