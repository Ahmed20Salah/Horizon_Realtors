import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/widget/bottom_bar.dart';

class Profile extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 24,
          ),
          Container(
            padding: EdgeInsets.only(
                right: 16.0, left: 16.0, top: 16.0, bottom: 10.0),
            child: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff363636)),
            ),
          ),
          _userPic(context),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Center(
              child: Text(
                '${_userRepository.user.name}',
                style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.mail,
                  size: 28.0,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${_userRepository.user.email}',
                  style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.phone,
                  size: 28.0,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${_userRepository.user.phone}',
                  style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          _editButton(context),
          SizedBox(
            height: 120.0,
          ),
          Center(
              child: Text(
            'Horizon Realtors®',
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff8F8F8F),
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 5.0,
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Made with ',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
              Icon(
                (Icons.favorite),
                size: 15,
                color: Color(0xff8F8F8F),
              ),
              Text(
                ' in Qatar',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
            ],
          ))
        ],
      ),
      bottomNavigationBar: CustomBottomBar(3),
    );
  }

  Center _userPic(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width - 140.0),
        height: 140.0,
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              minRadius: 140.0,
              backgroundColor: Colors.grey,
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                width: 32,
                height: 32,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Icon(
                  Icons.mode_edit,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _editButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff3FB1E3),
            borderRadius: BorderRadius.circular(24.0),
          ),
          height: 48.0,
          alignment: Alignment.center,
          child: Text(
            'Edit personal information',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
