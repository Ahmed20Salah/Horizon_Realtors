import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/blocs/user_bloc/user_bloc.dart';
import 'package:horizon_realtors/models/agency.dart';
import 'package:horizon_realtors/widget/logo.dart';

class AgencySearch extends StatefulWidget {
  Map userData;
  AgencySearch(this.userData);
  @override
  _AgencySearchState createState() => _AgencySearchState();
}

class _AgencySearchState extends State<AgencySearch> {
  final _bloc = UserBloc();
  List<Agency> _filterdData = [];
  int agencyId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff3FB1E3),
              Color(0xff6178B9),
            ],
            begin: Alignment(0, 0),
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Logo(true),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Do you work for which agency?',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty ||
                            val.length < 5 ||
                            val.contains(' ')) {
                          return 'please chosse a valid Agency';
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.search,
                      decoration: _inputDecoration('Search'),
                      onChanged: (val) {
                        _bloc.add(Search(val));
                      },
                    ),
                    BlocConsumer(
                      bloc: _bloc,
                      listener: (context, state) {
                        
                      },
                      builder: (context, state) {
                        return Container(
                          height: 300.0,
                          child: Stack(
                            children: <Widget>[
                              ListView.builder(
                                itemCount: _filterdData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Text(_filterdData[index].name),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        fillColor: Colors.white.withOpacity(.24),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        border: _inputBorder(),
        errorStyle: TextStyle(color: Color(0xffFCE187)),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Color(0xffFF9292)),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ));
  }

  _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.white),
    );
  }

  Widget _submit(context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            height: 48.0,
            alignment: Alignment.center,
            child: Text(
              'Submit',
              style: TextStyle(
                  color: Color(0xff6178B9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Map updated = {
              'name': widget.userData['name'],
              'email': widget.userData['email'],
              'phone': widget.userData['phone'],
              'password': widget.userData['password'],
              'role': '2',
              'agency_name': agencyId
            };
            _bloc.add(Register(updated));
          },
        );
      },
    );
  }
}
