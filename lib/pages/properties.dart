import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/blocs/properties_bloc/properties_bloc.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/pages/add_property.dart';
import 'package:horizon_realtors/pages/add_property.dart';
import 'package:horizon_realtors/repository/properties_repo.dart';
import 'package:horizon_realtors/widget/product.dart';

import '../widget/bottom_bar.dart';

class Properties extends StatefulWidget {
  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  int isSelected = 1;
  final _bloc = PropertiesBloc();

  static final _agencyRepository = PropertiesRepository();

  List<Post> _current;
  @override
  void initState() {
    if (_agencyRepository.userProperites == null) {
      print('from init');
      _bloc.add(GetProperties());
    }
    _current = _agencyRepository.availbale;
    super.initState();
  }

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
            SizedBox(
              height: 16.0,
            ),
            _search(context),
            SizedBox(
              height: 16.0,
            ),
            _switchButton(),
            SizedBox(
              height: 6,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200.0,
              child: BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _current.length,
                      itemBuilder: (context, index) {
                        return ProductWidget(_current[index]);
                      },
                    );
                  }
                },
              ),
            ),
            _listen()
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPropertyScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff3FB1E3),
      ),
    );
  }

  Container _switchButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            onTap: () {
              if (isSelected != 1) {
                setState(() {
                  isSelected = 1;
                  _current = null;
                  _current = _agencyRepository.availbale;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              width: 90.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected == 1
                        ? Color(0xff3FB1E3)
                        : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Available',
                style: TextStyle(
                  color:
                      isSelected == 1 ? Color(0xff3FB1E3) : Color(0xff8F8F8F),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            onTap: () {
              if (isSelected == 1) {
                setState(() {
                  isSelected = 2;
                  _current = null;

                  _current = _agencyRepository.sold;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              width: 90.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected == 2
                        ? Color(0xff3FB1E3)
                        : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Sold',
                style: TextStyle(
                  color:
                      isSelected == 2 ? Color(0xff3FB1E3) : Color(0xff8F8F8F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _search(BuildContext context) {
    return Container(
      height: 85.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Properties',
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xff363636),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12.0,
          ),
          Material(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              decoration: _inputDecoration('Search properties'),
            ),
          )
        ],
      ),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Color(0xff4E97D0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Color(0xff8F8F8F)),
      border: InputBorder.none,
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Color(0xffECECEC)),
    );
  }

  BlocListener<PropertiesBloc, dynamic> _listen() {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is HaveProperties) {
          _current = _agencyRepository.availbale;
        } else if (state is Error) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Container(
                alignment: Alignment.center,
                height: 20.0,
                child: Text(state.errors),
              ),
            ),
          );
        }
        return Container();
      },
      child: Container(),
    );
  }
}
