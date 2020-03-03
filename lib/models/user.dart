import 'package:flutter/cupertino.dart';

class User {
  String name;
  String email;
  String password;
  String phone;
  String token;
  UserType type;
  String agencyname;
  User(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.phone,
      @required this.type,
      this.agencyname});

  User.fromMap(map) {
    this.name = map['name'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.token = map['token'];
    this.type = map['type'] == 1
        ? UserType.EndUser
        : map['type'] == 2 ? UserType.Agent : UserType.Agency;
    map['type'] == 2
        ? this.agencyname = map['agency_name']
        : this.agencyname = null;
  }
  toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['type'] = this.type == UserType.EndUser
        ? 1
        : this.type == UserType.Agency ? 2 : 3;
    map['agancy_name'] = this.agencyname;
    return map;
  }
}

enum UserType { EndUser, Agency, Agent }
