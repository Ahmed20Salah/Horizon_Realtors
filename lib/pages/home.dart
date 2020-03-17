import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:horizon_realtors/widget/bottom_bar.dart';

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
  var width;
  static List _fiters = ['Last month', 'Last year'];
  var inialvalue = _fiters[0];
  final _fontColor = Color(0xff363636);
  final _numColor = Color(0xff946BAB);
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 115.0;
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
              margin: EdgeInsets.all(16.0),
              height: 160.0,
              child: Column(
                children: <Widget>[
                  _profit(),
                  SizedBox(
                    height: 6,
                  ),
                  _details()
                ],
              ),
            ),
            _chart(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(0),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _dataItem('Earned', '\$2.265,00'),
            _dataItem('Properties sold', 4),
            _dataItem('Properties rent', 2)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: _dataItem('Avail. properties', 1),
        )
      ],
    );
  }

  Column _dataItem(String title, count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: _fontColor, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '$count',
          style: TextStyle(
              color: _numColor, fontWeight: FontWeight.bold, fontSize: 20.0),
        )
      ],
    );
  }

  Row _profit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(
            'Profit',
            style: TextStyle(
                color: _fontColor, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffECECEC),
              ),
              borderRadius: BorderRadius.circular(20.0)),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          width: 150.0,
          height: 40.0,
          child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  inialvalue = value;
                });
              },
              style: TextStyle(color: Colors.black),
              value: inialvalue,
              items: _fiters.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Container(
                    child: Text(
                      item,
                      style: TextStyle(),
                    ),
                  ),
                );
              }).toList()),
        )
      ],
    );
  }

  Widget _chart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Profit along time',
            style: TextStyle(
                color: _fontColor, fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xffECECEC))),
            padding: EdgeInsets.all(5),
            height: 200.0,
            child: Echarts(
              option: '''
                   {
                    xAxis: {
                      type: 'category',
                      boundaryGap: false,
                      data: ['DEC 20 \u1d40\u1d34', 'DEC 27 \u1d40\u1d34', 'JAN 3 \u1d40\u1d34', 'JAN 11 \u1d40\u1d34', 'JAN 18 \u1d40\u1d34'],
                      axisLabel:{
                        color:"#6178B9",
                      },
                      axisTick:{
                        show:false,
                      },
                      axisLine:{
                        show: false
                      }
                    },
                    yAxis: {
                      type: 'value',
                      show: false,
                      boundaryGap:[0,0]
                     
                    },
                    width: $width,
                    height: 108,
                    series: [{
                      data: [820, 932, 901, 934, 1290, 1330, 1320],
                      type: 'line',
                      symbol: 'circle',
                      symbolSize: 8,
                      lineStyle: {
                          color: '#3FB1E3',
                          width: 1,
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
          ),
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
