import 'package:flutter/material.dart';
import 'package:horizon_realtors/models/user.dart';

class AgentWidegt extends StatelessWidget {
  final User user;
  AgentWidegt(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.name}',
                    style: TextStyle(
                        color: Color(0xff2D2D2D),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tezopa\'s acreddited agent',
                    style: TextStyle(
                      color: Color(0xff8F8F8F),
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset('assets/dark-map-pin.png'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Qatar',
                        style:
                            TextStyle(color: Color(0xff363636), fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Container(
            height: 32,
            width: 60.0,
            child: Image.asset(
              'assets/1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
