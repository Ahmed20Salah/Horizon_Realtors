import 'dart:convert';

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
  List<String> agenies = [];

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
      }
      return jsonDecode(re.body);
    } catch (e) {
      print(e);
      return {'status': false, 'error': 'verify your Connection!'};
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
      }
      return jsonDecode(re.body);
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'verify your Connection!'};
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
        agenies.addAll(data['data']);
        return {'status': true};
      } else {
        return {'status': false, 'message': data['error']};
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'Connecation Problem!'};
    }
  }

  List<String> search(String name) {
    List<String> _filetrd = [];
    agenies.forEach((element) {
      if (element == name) {
        _filetrd.add(element);
      }
    });
    return _filetrd;
  }
}
