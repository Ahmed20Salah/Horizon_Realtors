import 'package:flutter/material.dart';

class AgencyScreen extends StatelessWidget {
  final Color _mainColor = Color(0xff363636);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            _title(),
            SizedBox(
              height: 20.0,
            ),
            _avatar(),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Listed properties',
                style: TextStyle(
                    color: _mainColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _bottombar(context),
    );
  }

  Widget _bottombar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffECECEC)))),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 205.0,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xffEEF5F8)),
                alignment: Alignment.center,
                child: Text(
                  'Request a call back',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3FB1E3)),
                ),
              ),
            ),
          ),
          Container(
            width: 150.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xff3FB1E3)),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      size: 20,
                      textDirection: TextDirection.rtl,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Chat Now',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _avatar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 95,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 45.0,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          SizedBox(
            width: 19,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('0048286')
                  ],
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('salah@mgail.con')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: _mainColor,
                  ),
                  onPressed: null),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Brad Johnson',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: _mainColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Tezopa\'s acreddited agent',
                    style: TextStyle(fontSize: 16, color: _mainColor),
                  )
                ],
              ),
            ],
          ),
          Container(
            width: 100.0,
            height: 55,
            child: Image.asset(
              'assets/1.jpg',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
