import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool willPop;
  Logo(this.willPop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 34.0),
      height: 240.0,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          willPop
              ? InkWell(
                  child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.3),
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
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              : Container(
                    height: 45.0,

              ),
          Container(
            height: 160.0,
            alignment: Alignment.center,
            child: Text(
              'Horizon Realtors®',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
