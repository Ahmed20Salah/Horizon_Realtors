import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/widget/agent_widget.dart';

class Description extends StatefulWidget {
  final Post _post;
  Description(this._post);
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final List<String> _imgs = ['assets/1.jpg', 'assets/2.jpg', 'assets/3.jpg'];
  final _mainColor = Color(0xff3FB1E3);
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _slider(context),
            _title(),
            _financialDate(),
            _postData(),
            _description(),
            _mapScreenshot(),
            _poster()
          ],
        ),
      ),
    );
  }

  Widget _slider(context) {
    return Container(
      color: Colors.red,
      height: 300.0,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            viewportFraction: 1.0,
            height: 300.0,
            items: _imgs.map((e) {
              return Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(e),
                  ),
                ),
              );
            }).toList(),
            onPageChanged: (val) {
              setState(() {
                current = val;
              });
            },
          ),
          Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 37.0),
                    width: 45.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Color(0xff363636).withOpacity(0.48),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10.0),
                    width: 50,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xff363636),
                    ),
                    child: Text(
                      '${++current} / ${_imgs.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 5, bottom: 10.0, right: 15.0, left: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '725 Shaika Bin Rahin',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff363636)),
                ),
                ButtonBar(
                  buttonPadding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    InkWell(
                        child: Icon(
                          Icons.share,
                          color: Color(0xff363636),
                        ),
                        onTap: null),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        child: Icon(
                          Icons.favorite_border,
                          color: Color(0xff363636),
                        ),
                        onTap: null),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 30.0,
            child: Row(
              children: <Widget>[
                Image.asset('assets/map-pin.png'),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Bin Jasim Road, Al Wakra, Doha',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8F8F8F)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _financialDate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 90,
                height: 28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: _mainColor),
                child: Text(
                  widget._post.type == PropertyType.ForRent
                      ? 'FOR RENT'
                      : 'FOR SALE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              // widget._post.financeAvailability
              //     ?

              Container(
                alignment: Alignment.center,
                width: 170,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xffEEF5F8),
                ),
                child: Text(
                  'FINANCE AVAILABLE',
                  style: TextStyle(
                      color: _mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
              // : Container()
            ],
          ),
          Text(
            '\$${widget._post.price}',
            style: TextStyle(
                color: Color(0xff6178B9),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _postData() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Category',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Image.asset('assets/home.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget._post.categoryId}',
                    style: TextStyle(color: Color(0xff363636), fontSize: 16),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bedrooms',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Image.asset('assets/bed.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget._post.bedrooms}',
                    style: TextStyle(color: Color(0xff363636), fontSize: 16),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bathrooms',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Image.asset('assets/bath.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget._post.bathrooms}',
                    style: TextStyle(color: Color(0xff363636), fontSize: 16),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Area',
                style: TextStyle(color: Color(0xff8F8F8F)),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Image.asset('assets/area.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${widget._post.area} ft\u00B2',
                    style: TextStyle(color: Color(0xff363636), fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 15.0),
        child: Text(
          '${widget._post.description}',
          style: TextStyle(color: Color(0xff363636), fontSize: 16.0),
          maxLines: 5,
          softWrap: true,
        ),
      ),
    );
  }

  Widget _mapScreenshot() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 190.0,
      child: Image.asset('assets/map.png', fit: BoxFit.cover),
    );
  }

  Widget _poster() {
    return Container(
      margin: EdgeInsets.only(top: 24, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Listed by',
              style: TextStyle(color: Color(0xff8F8F8F)),
            ),
          ),
          AgentWidegt(widget._post.user),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {}
}
