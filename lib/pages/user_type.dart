import 'package:flutter/material.dart';
import 'package:horizon_realtors/blocs/user_bloc/user_bloc.dart';
import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/pages/agency_search.dart';
import 'package:horizon_realtors/pages/register.dart';
import 'package:horizon_realtors/widget/logo.dart';

class UserTypeScreen extends StatefulWidget {
  final Map data;
  UserTypeScreen({this.data});
  @override
  _UserType createState() => _UserType();
}

class _UserType extends State<UserTypeScreen> {
  UserType type;
  bool frelancer;
  final _bloc = UserBloc();

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
                        widget.data == null
                            ? 'What better describes you?'
                            : 'How do you work?',
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
                              child: type == UserType.Agent || frelancer == true
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
                                widget.data == null
                                    ? 'I`m an agent'
                                    : 'I work as freelancer',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            if (widget.data == null) {
                              type = UserType.Agent;
                            } else {
                              frelancer = true;
                            }
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
                              child:
                                  type == UserType.Agency || frelancer == false
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
                                widget.data == null
                                    ? 'I`m an agency'
                                    : 'I work for an agency',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            if (widget.data == null) {
                              type = UserType.Agency;
                            } else {
                              frelancer = false;
                            }
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
          color: type != null || frelancer != null
              ? Color(0xffEEF5F8)
              : Color(0xffEEF5F8).withOpacity(.6),
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 48.0,
        alignment: Alignment.center,
        child: Text(
          widget.data == null ? 'Continue' : 'Submit',
          style: TextStyle(
              color: Color(0xff6178B9),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        if (widget.data == null) {
          if (type == null) {
            return;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterPage(type: type)));
          }
        } else {
          if (frelancer == null) {
            return;
          } else if (frelancer) {
            Map _updated = {
              'name': widget.data['name'],
              'email': widget.data['email'],
              'phone': widget.data['phone'],
              'password': widget.data['password'],
              'role': '2'
            };
            _bloc.add(Register(_updated));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgencySearch(widget.data)));
          }
        }
      },
    );
  }
}
