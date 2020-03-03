import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        children: <Widget>[
          _picWidget(context),
          _title(context),
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            height: 1.0,
            color: Color(0xffECECEC),
          ),
          _details()
        ],
      ),
    );
  }

  Container _details() {
    return Container(
          child: Row(
            children: <Widget>[
              Image.asset('assets/home.png'),
              SizedBox(
                width: 35.0,
              ),
              Container(
                height: 25.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/bed.png'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 35.0,
              ),
              Container(
                height: 25.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/bath.png'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '4',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 35.0,
              ),
              Container(
                height: 25.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/area.png'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '168 ft\u00B2',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Container _title(BuildContext context) {
    return Container(
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 70 / 100 * MediaQuery.of(context).size.width - 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '28 Al Ghanim Bldg',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff363636),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Al Ikhaa St 880, Frij Bin Mahmoud, Doha',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff8F8F8F),
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              '\$899,99',
              style: TextStyle(
                  color: Color(0xff6178B9),
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          )
        ],
      ),
    );
  }

  Container _picWidget(BuildContext context) {
    return Container(
      height: 162.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
            image: AssetImage('assets/photo.jpg'), fit: BoxFit.cover),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child:
                InkWell(child: Icon(Icons.favorite , color: Colors.white,)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: 54.0,
                  height: 26.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff3FB1E3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Rent',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
