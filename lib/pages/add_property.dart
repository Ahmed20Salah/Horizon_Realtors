import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/blocs/properties_bloc/properties_bloc.dart';
import 'package:horizon_realtors/pages/google_maps.dart';
import 'package:horizon_realtors/pages/properties.dart';
import 'package:horizon_realtors/utilts/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pusher/pusher.dart' as lis;

enum _CategoryType { Apartment, Commercial, House, Land }
enum _DropdownType { Bathrooms, Bedrooms }

class AddPropertyScreen extends StatefulWidget {
  final Map data;
  AddPropertyScreen({this.data});
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddPropertyScreen> {
  final _bloc = PropertiesBloc();
  Constant _constant = Constant();
  Color _titleColor = Color(0xff363636);
  Map _newData;
  var img;
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _area = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool available;
  int type;
  _CategoryType _categoryType;
  Color _mainColor = Color(0xff3FB1E3);
  List<int> _bedrooms = [1, 2, 3, 4, 5];
  int _bedroomsValue;
  int _bathroomsValue;
  int size;
  // Channel _channel;

  // void testSocket() async {
  //   Future _pusher = Pusher.init(
  //       'b20c5969416dc6417da6', PusherOptions(cluster: 'eu', encrypted: true),
  //       enableLogging: true);
  //   Pusher.connect(onConnectionStateChange: (con) {
  //     print(con.currentState);
  //   }, onError: (error) {
  //     print(error);
  //   });
  //   Channel _channel =
  //       await Pusher.subscribe('testChannel').then((value) async {
  //     print(value.name);
  //     value.bind('test_event', (val) {
  //       print('coming data :${val.data}');
  //     });
  //   });
  // _channel.bind('test_event', (event) {
  //   print(event.data);
  //   print(event.event);
  //   print(event.channel);
  // });

  //  lis.PusherOptions options =
  //     new lis.PusherOptions(encrypted: true, cluster: 'eu');
  // lis.Pusher pusher = new lis.Pusher(
  //     '969611', 'b20c5969416dc6417da6', 'ea238bd1632bdcead9f9', options);
  // lis.Response response = await pusher.trigger(
  //     ['testChannel'], 'test_event', {'message': 'Hi Gouda'});
  // lis.Response result = await pusher.get("/channels");
  // // print(response.toString());
  // // print(result.message);
  // }

  @override
  void initState() {
    // testSocket();
    print(widget.data);
    _bedroomsValue = _bedrooms[0];
    _bathroomsValue = _bedrooms[0];
    _newData = {
      'imgs': widget.data == null ? List<dynamic>() : widget.data['imgs'],
      'lant': widget.data == null ? null : widget.data['lant'],
      'lang': widget.data == null ? null : widget.data['lang'],
      'address': widget.data == null ? '' : widget.data['address'],
      'main_address': widget.data == null ? '' : widget.data['main_address'],
    };

    if (widget.data != null) {
      print('pass');
      _description.text = widget.data['description'];
      _price.text = widget.data['price'];
      type = widget.data['type'];
      available = widget.data['available'];
      _bathroomsValue = widget.data['bathrooms'];
      _bedroomsValue = widget.data['bedrooms'];
      _area.text = widget.data['area'];
      _categoryType = widget.data['category'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 24.0,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Add Property',
                    style: TextStyle(
                        color: _titleColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _pictures(),
                SizedBox(
                  height: 15.0,
                ),
                _descriptionInput(),
                SizedBox(
                  height: 15.0,
                ),
                _priceInput(),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 66.0,
                  child: Row(
                    children: <Widget>[
                      _typeWidget(),
                      SizedBox(
                        width: 25.0,
                      ),
                      _availableWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 17.0,
                ),
                _locationInput(),
                SizedBox(
                  height: 20.0,
                ),
                _category(),
                SizedBox(
                  height: 17.0,
                ),
                _dimensions(),
                _submitButton(context),
                _listen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _submitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: 90.0,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xffEEF5F8),
              ),
              child: Text(
                'Cancle',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff3FB1E3)),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: 260.0,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xff3FB1E3),
              ),
              child: Text(
                'Add property',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            onTap: () {
              _formKey.currentState.save();
              if (_formKey.currentState.validate() &&
                  _newData['imgs'].length > 0 &&
                  available != null &&
                  type != null &&
                  _categoryType != null &&
                  _newData['lant'] != null) {
                _bloc.add(AddProperties({
                  'imgs': _newData['imgs'],
                  'description': _description.text,
                  'price': _price.text,
                  'type': type,
                  'available': available,
                  'lant': _newData['lant'],
                  'lang': _newData['lang'],
                  'address': _newData['address'],
                  'main_address': _newData['main_address'],
                  'category': _categoryType,
                  'bathroom': _bathroomsValue,
                  'badrooms': _bedroomsValue,
                  'area': _area.text
                }));
              }
            },
          )
        ],
      ),
    );
  }

  Widget _dimensions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _dropdownItems('Bedrooms', _bedrooms, _DropdownType.Bedrooms),
        _dropdownItems('Bathrooms', _bedrooms, _DropdownType.Bathrooms),
        Container(
          width: 100.0,
          height: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Area',
                style: _titleStyle(),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 82,
                      child: TextFormField(
                        controller: _area,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty ||
                              val.length == 0 ||
                              val.contains(' ')) {
                            return '';
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          border: _inputBorder(),
                          focusedBorder: _inputBorder(),
                          enabledBorder: _inputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'ft\u00B2',
                      style: TextStyle(color: Color(0xff8F8F8F)),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Container _dropdownItems(title, List<int> items, value) {
    return Container(
      width: 90,
      height: 75,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: _titleStyle(),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 85,
            height: 40.0,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
                borderRadius: BorderRadius.circular(20.0)),
            child: DropdownButton(
              iconSize: 20.0,
              underline: Container(),
              value: value == _DropdownType.Bathrooms
                  ? _bathroomsValue
                  : _bedroomsValue,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff363636),
              ),
              items: items.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Container(
                    padding: EdgeInsets.only(left: 14.0),
                    width: 55.0,
                    height: 20.0,
                    child: Text(
                      e.toString(),
                      style: TextStyle(color: Color(0xff8F8F8F)),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                print(val);
                setState(() {
                  value == _DropdownType.Bathrooms
                      ? _bathroomsValue = val
                      : _bedroomsValue = val;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container _category() {
    return Container(
      height: 65.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Category',
            style: _titleStyle(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _categoryType == _CategoryType.Apartment
                        ? _mainColor
                        : Color(0xffECECEC),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _categoryType = _CategoryType.Apartment;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                    height: 38,
                    alignment: Alignment.center,
                    child: Text(
                      'Apartment',
                      style: TextStyle(
                        color: _categoryType == _CategoryType.Apartment
                            ? _mainColor
                            : Color(0xff8F8F8F),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _categoryType == _CategoryType.Commercial
                        ? _mainColor
                        : Color(0xffECECEC),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _categoryType = _CategoryType.Commercial;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                    height: 38,
                    alignment: Alignment.center,
                    child: Text(
                      'Commercial',
                      style: TextStyle(
                        color: _categoryType == _CategoryType.Commercial
                            ? _mainColor
                            : Color(0xff8F8F8F),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _categoryType == _CategoryType.House
                        ? _mainColor
                        : Color(0xffECECEC),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _categoryType = _CategoryType.House;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                    height: 38,
                    alignment: Alignment.center,
                    child: Text(
                      'House',
                      style: TextStyle(
                        color: _categoryType == _CategoryType.House
                            ? _mainColor
                            : Color(0xff8F8F8F),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _categoryType == _CategoryType.Land
                        ? _mainColor
                        : Color(0xffECECEC),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _categoryType = _CategoryType.Land;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
                    height: 38,
                    alignment: Alignment.center,
                    child: Text(
                      'Land',
                      style: TextStyle(
                        color: _categoryType == _CategoryType.Land
                            ? _mainColor
                            : Color(0xff8F8F8F),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _locationInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Geolocation',
            style: TextStyle(
                color: _titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            alignment:
                widget.data == null ? Alignment.center : Alignment.bottomRight,
            padding: EdgeInsets.all(8.0),
            height: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.data == null
                    ? AssetImage('assets/map.png')
                    : NetworkImage(
                        'https://maps.googleapis.com/maps/api/staticmap?center=${_newData['lant']},${_newData['lang']}&zoom=16&size=600x400&key=${_constant.apiKey}'),
              ),
            ),
            child: InkWell(
              onTap: () {
                print('hhhhhhhhhhhhhhhhhhhh');
                print(_description.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapsViewScreen({
                      'imgs': _newData['imgs'],
                      'description': _description.text,
                      'price': _price.text,
                      'type': type,
                      'available': available,
                      'bathrooms': _bathroomsValue,
                      'bedrooms': _bedroomsValue,
                      'area': _area.text,
                      'category': _categoryType
                    }),
                  ),
                );
              },
              child: widget.data == null
                  ? Container(
                      alignment: Alignment.center,
                      width: 176,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xff3FB1E3),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Set geolocation',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: 75.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: Color(0xff3FB1E3),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
            ),
          ),
          widget.data == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${_newData['address']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                ),
          widget.data == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '${_newData['main_address']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget _typeWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Type',
            style: TextStyle(
                color: _titleColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6,
          ),
          _typeSwitchButton()
        ],
      ),
    );
  }

  Widget _availableWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Finance availability',
            style: TextStyle(
                color: _titleColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6,
          ),
          _availableSwitchButton()
        ],
      ),
    );
  }

  Widget _typeSwitchButton() {
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
              if (type != 1) {
                setState(() {
                  type = 1;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 60.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: type == 1 ? Color(0xff3FB1E3) : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Rent',
                style: TextStyle(
                  color: type == 1 ? Color(0xff3FB1E3) : Color(0xff8F8F8F),
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
              if (type != 2) {
                setState(() {
                  type = 2;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 60.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: type == 2 ? Color(0xff3FB1E3) : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Sale',
                style: TextStyle(
                  color: type == 2 ? Color(0xff3FB1E3) : Color(0xff8F8F8F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _availableSwitchButton() {
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
              if (available == null || !available) {
                setState(() {
                  available = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 60.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: available == true
                        ? Color(0xff3FB1E3)
                        : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'Yas',
                style: TextStyle(
                  color:
                      available == true ? Color(0xff3FB1E3) : Color(0xff8F8F8F),
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
              if (available == null || available) {
                setState(() {
                  available = false;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40.0,
              width: 60.0,
              decoration: BoxDecoration(
                border: Border.all(
                    color: available == false
                        ? Color(0xff3FB1E3)
                        : Color(0xffECECEC)),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'No',
                style: TextStyle(
                  color: available == false
                      ? Color(0xff3FB1E3)
                      : Color(0xff8F8F8F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceInput() {
    return Container(
      height: 95.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price',
            style: _titleStyle(),
          ),
          Container(
            width: 102,
            margin: EdgeInsets.only(top: 5),
            child: TextFormField(
              controller: _price,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.isEmpty || val.length == 0 || val.contains(' ')) {
                  return '';
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                border: _inputBorder(),
                focusedBorder: _inputBorder(),
                enabledBorder: _inputBorder(),
                errorStyle: TextStyle(fontSize: 10.0),
                prefix: Text('\$ '),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionInput() {
    return Container(
      height: 95.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Description',
            style: _titleStyle(),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: TextFormField(
              controller: _description,
              validator: (val) {
                if (val.isEmpty || val.length == 0) {
                  return 'please enter a valid value';
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                border: _inputBorder(),
                focusedBorder: _inputBorder(),
                enabledBorder: _inputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Color(0xffECECEC),
      ),
    );
  }

  TextStyle _titleStyle() {
    return TextStyle(
        color: _titleColor, fontSize: 16.0, fontWeight: FontWeight.bold);
  }

  Widget _pictures() {
    return Container(
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pictures',
            style: TextStyle(
                color: _titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _newData['imgs'].length + 1,
              itemBuilder: (context, index) {
                if (index == _newData['imgs'].length) {
                  return InkWell(
                    onTap: () async {
                      _choosePickType(context);
                    },
                    child: Container(
                      width: 112.0,
                      height: 112.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffECECEC))),
                      child: Icon(
                        Icons.add,
                        color: _titleColor,
                      ),
                    ),
                  );
                }
                return Container(
                  width: 112.0,
                  height: 112.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(_newData['imgs'][index]),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _choosePickType(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                _pickIamge(ImageSource.camera).then((val) {
                  Navigator.pop(context);
                });
              },
              child: Container(
                child: Icon(
                  Icons.camera_alt,
                  color: _titleColor,
                  size: 40.0,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _pickIamge(ImageSource.gallery).then((val) {
                  Navigator.pop(context);
                });
              },
              child: Icon(
                Icons.photo,
                color: _titleColor,
                size: 40.0,
              ),
            ),
          ],
        );
      },
    );
  }

  Future _pickIamge(source) async {
    var _image = await ImagePicker.pickImage(source: source);
    print(_image);
    if (_image != null) {
      setState(() {
        img = _image;
        _newData['imgs'].add(_image);
      });
    }
    return true;
  }

  BlocListener<PropertiesBloc, dynamic> _listen() {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Loading) {
          return showDialog(
            context: context,
            child: AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
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
        } else if (state is AddedProperty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Properties()),
          );
        }
        return Container();
      },
      child: Container(),
    );
  }
}
