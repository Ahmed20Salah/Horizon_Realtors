import 'dart:convert';

import 'package:horizon_realtors/models/agency.dart';
import 'package:horizon_realtors/utilts/constant.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();
  UserRepository._internal();
  factory UserRepository() {
    return _userRepository;
  }

  User user;
  List<Agency> agenies = [];

  login(Map log) async {
    try {
      var re = await http.post(
          '$url/api/auth/login?email=${log['email']}&password=${log['password']}');
      Map data = jsonDecode(re.body);
      // print(data);

      if (data['status']) {
        // print(data['data']);
        user = User.fromMap(data['data']);
        SharedPreferences per = await SharedPreferences.getInstance();
        // print(user.token);
        per.setString('token', user.token);
        per.setString('type', user.toMap()['role']);
        per.setInt('id', user.id);

        // print(user.name);
        return data;
      }
      return data;
    } catch (e) {
      print(e);
      return {'status': false, 'errors': 'verify your Connection!'};
    }
  }

  register(Map input) async {
    print(input['role']);
    try {
      var re = await http.post(
          '$url/api/auth/register?name=${input['name']}&email=${input['email']}&password=${input['password']}&role=${input['role']}&agancy_name=${input['agencyname']}&phone=${input['phone']}');

      Map data = jsonDecode(re.body);
      print(data);
      if (data['status']) {
        user = User.fromMap(data['data']);
        SharedPreferences per = await SharedPreferences.getInstance();
        print(user.token);
        per.setString('token', user.token);
        per.setString('type', user.toMap()['role']);
        per.setInt('id', user.id);
        return data;
      }
      return data;
    } catch (e) {
      print(e);
      return {'status': false, 'errors': 'verify your Connection!'};
    }
  }

  checkAuth() async {
    print('checking');
    SharedPreferences per = await SharedPreferences.getInstance();
    var token = per.getString('token');
    if (token == null) {
      return false;
    }
    user = User.fromMap({
      'token': token,
      'role': per.getString('type'),
      'id': per.getInt('id')
    });
    print(user.type);
    return true;
  }

  Future<Map<String, dynamic>> getAgencies() async {
    try {
      var re = await http.get('$url/api/auth/agancys_names');
      var data = jsonDecode(re.body);
      print(data);
      if (data['status']) {
        print(data['data']);
        for (var item in data['data']) {
          agenies.add(Agency.fromMAp(item));
        }
        return {'status': true};
      } else {
        return {'status': false, 'errors': data['errors']};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'errors': 'Connecation Problem!'};
    }
  }

  List<Agency> search(String name) {
    List<Agency> _filetrd = [];
    print(agenies.length);
    agenies.forEach((element) {
      if (element.name.contains(name)) {
        print(element.name);
        _filetrd.add(element);
      }
    });
    return _filetrd;
  }
}
