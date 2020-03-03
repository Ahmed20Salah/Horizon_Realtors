import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:horizon_realtors/widget/bottom_bar.dart';
import 'package:horizon_realtors/widget/product.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), border: Border.all()),
              height: 200.0,
              child: Echarts(
                option: '''
               {
                xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: ['DEC 20 \u1d40\u1d34', 'DEC 27', 'JAN 3', 'JAN 11', 'JAN 18'],
                  axisLabel:{
                    color:"#6178B9",
                  }
                },
                yAxis: {
                  type: 'value',
                  show: false,
                 
                },
                
                series: [{
                  data: [820, 932, 901, 934, 1290, 1330, 1320],
                  type: 'line',
                  symbol: 'circle',
                  symbolSize: 8,
                  lineStyle: {
                      color: '#3FB1E3',
                      width: 4,
                      type: 'solid'
                  },
                  itemStyle: {
                      borderWidth: 1,
                      borderColor: "#3FB1E3",
                      color: "#3FB1E3"
                  },
                  label:{
                    show: true
                  },
                  areaStyle: {
                    color:"#EEF5F8"
                  }
                 
                }],
              }
               ''',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(0),
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
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: .5),
                    decoration: BoxDecoration(
                      border: Border(
                          // bottom: BorderSide(color: Colors.white, width: 2),
                          ),
                    ),
                    child: Text(
                      'For Sale',
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
            decoration: _inputDecoration('Find agents, agencies & properties'),
          )
        ],
      ),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search),
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
