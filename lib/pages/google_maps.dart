import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horizon_realtors/pages/add_property.dart';

class GoogleMapsViewScreen extends StatefulWidget {
  final Map data;
  GoogleMapsViewScreen(this.data);
  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsViewScreen> {
  GoogleMapController _controller;
  TextEditingController _controllerSearch = TextEditingController();
  final Completer<GoogleMapController> _completer = Completer();
  static CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(37.43296265331129, -122.08832357078792), zoom: 20.0);

  static MarkerId _id = MarkerId('1');
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    _id: Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.43296265331129, -122.08832357078792),
    ),
  };
  String _firstAddress = '';
  String _fullAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 24),
              height: 90,
              color: Colors.white,
              child: Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xff363636),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width - 60.0,
                      child: TextFormField(
                        controller: _controllerSearch,
                        onEditingComplete: _search,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            border: _inputBorder(),
                            enabledBorder: _inputBorder(),
                            focusedBorder: _inputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 240,
              child: GoogleMap(
                initialCameraPosition: _cameraPosition,
                markers: Set<Marker>.of(markers.values),
                onCameraMove: (cam) async {
                  setState(() {
                    markers[_id] = Marker(markerId: _id, position: cam.target);
                  });
                },
                onCameraIdle: () async {
                  var location;

                  try {
                    location = await Geocoder.google(
                            'AIzaSyAT07iMlfZ9bJt1gmGj9KhJDLFY8srI6dA')
                        .findAddressesFromCoordinates(
                      Coordinates(markers[_id].position.latitude,
                          markers[_id].position.longitude),
                    );
                    setState(() {
                      _controllerSearch.text = location.first.addressLine;
                      List<String> _address =
                          location.first.addressLine.split(',');
                      _firstAddress = _address[0];
                      _fullAddress = '';
                      for (int i = 1; i < _address.length; i++) {
                        _fullAddress += _address[i];
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                onMapCreated: (con) {
                  _completer.complete(con);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16.0, top: 7),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 145,
              child: ListView(
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  Text(
                    'Cuurent Location',
                    style: TextStyle(color: Color(0xff8F8F8F)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    _firstAddress,
                    style: TextStyle(
                        color: Color(0xff363636),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    _fullAddress,
                    style: TextStyle(color: Color(0xff363636), fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Color(0xff3FB1E3),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Save geolocation',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        var _newData = widget.data;
                        _newData['lant'] = markers[_id].position.latitude;
                        _newData['lang'] = markers[_id].position.longitude;
                        _newData['address'] = _firstAddress;
                        _newData['main_address'] = _fullAddress;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPropertyScreen(
                              data: _newData,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _search() async {
    var location =
        await Geocoder.google('AIzaSyAT07iMlfZ9bJt1gmGj9KhJDLFY8srI6dA')
            .findAddressesFromQuery(_controllerSearch.text);
    print(location.first.featureName);
    print(location.first.addressLine);
    try {} catch (e) {
      print(e);
    }
    if (location != null) {
      _controller = await _completer.future;
      setState(() {
        _controller.moveCamera(
          CameraUpdate.newCameraPosition(
            _cameraPosition = CameraPosition(
              target: LatLng(location.first.coordinates.latitude,
                  location.first.coordinates.longitude),
              zoom: 20.0,
            ),
          ),
        );

        markers[_id] = Marker(
          markerId: _id,
          position: LatLng(
            location.first.coordinates.latitude,
            location.first.coordinates.longitude,
          ),
        );
        _firstAddress = location.first.featureName;
        _fullAddress = location.first.addressLine;
      });
    }
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Color(0xffECECEC),
      ),
    );
  }
}
