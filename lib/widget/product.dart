import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      height: 255,
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          _picWidget(context),
          Container(
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
                  child: Text('\$899,99' , style: TextStyle(color:Color(0xff6178B9), fontWeight: FontWeight.bold , fontSize: 28),),
                )
              ],
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
        image: DecorationImage(
            image: AssetImage('assets/photo.jpg'), fit: BoxFit.cover),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child:
                IconButton(icon: Icon(Icons.favorite_border), onPressed: null),
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
