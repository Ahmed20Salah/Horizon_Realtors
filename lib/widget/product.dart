import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizon_realtors/blocs/properties_bloc/properties_bloc.dart';
import 'package:horizon_realtors/models/mode.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/pages/add_property.dart';
import 'package:horizon_realtors/pages/description.dart';
import 'package:horizon_realtors/utilts/constant.dart';

import '../models/user.dart';
import '../repository/user_repo.dart';

class ProductWidget extends StatelessWidget {
  final Post post;
  ProductWidget(this.post);

  final _userRepository = UserRepository();
  final Constant _constant = Constant();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 255,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Description(post),
          ),
        );
      },
    );
  }

  Container _picWidget(BuildContext context) {
    return Container(
      height: 162.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
            image:
                NetworkImage('${_constant.url}/public/posts/${post.imgs[0]}'),
            fit: BoxFit.cover),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 40,
              height: 40,
              child: _userRepository.user.type == UserType.EndUser
                  ? InkWell(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        print('taped');
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              CustomBottomSheetBar(post: post),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.more_vert,
                          size: 29,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
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
                    post.type == 1 ? 'Rent' : 'Sale',
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
              '\$${post.price}',
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
                  '${post.bedrooms}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  '${post.bathrooms}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  '${post.area} ft\u00B2',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheetBar extends StatelessWidget {
  final Post post;
  CustomBottomSheetBar({Key key, this.post}) : super(key: key);
  final _bloc = PropertiesBloc();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      message: Text(
        'Property management',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xff363636)),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.edit,
                size: 20.0,
                color: Color(0xff3FB1E3),
              ),
              SizedBox(
                width: 10.0,
              ),
              MaterialButton(
                padding: EdgeInsets.all(0.0),
                height: 10.0,
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPropertyScreen(mode: Mode.Edit, data: post.toMap(),)));
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Color(0xff363636), fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(
                Icons.done,
                color: Color(0xff31CF37),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Mark as sold',
                style: TextStyle(color: Color(0xff363636), fontSize: 20.0),
              )
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.delete,
                color: Color(0xffFF2129),
              ),
              SizedBox(
                width: 10.0,
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  'Delete',
                  style: TextStyle(color: Color(0xff363636), fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
