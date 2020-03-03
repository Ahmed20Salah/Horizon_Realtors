import 'package:flutter/material.dart';
import 'package:horizon_realtors/widget/product.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var cat = [
    {'name': 'Agents', 'icon': 'assets/agent.png'},
    {'name': 'Agency', 'icon': 'assets/agency.png'},
    {'name': 'Apartment', 'icon': 'assets/apartment.png'},
    {'name': 'Commrical', 'icon': 'assets/commrical.png'},
    {'name': 'House', 'icon': 'assets/house.png'},
    {'name': 'Land', 'icon': 'assets/land.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 24.0,
              color: Color(0xff3FB1E3),
            ),
            _search(context),
            _navigationBy(context),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Highlights',
                    style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.red,
                    height: MediaQuery.of(context).size.height - 400.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index){
                      return ProductWidget();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _navigationBy(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 145.0,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Navigate by category',
            style: TextStyle(
                color: Color(0xff363636),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff3FB1E3),
                          ),
                          child: Image.asset(cat[index]['icon']),
                        ),
                        Text(cat[index]['name'])
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Container _search(BuildContext context) {
    return Container(
      height: 155.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3FB1E3),
            Color(0xff6178B9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Start your Search',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: .5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Text(
                      'For rent',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
              textInputAction: TextInputAction.search,
              decoration:
                  _inputDecoration('Find agents, agencies & properties'))
        ],
      ),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Color(0xff8F8F8F), fontSize: 14),
      border: InputBorder.none,
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
}
