import 'dart:convert';

import 'package:horizon_realtors/utilts/constant.dart';

import 'package:http/http.dart' as http;

import '../models/user.dart';

User user;

login(Map log) async {
  try {
    print(log);
    print(log['email']);
    var re = await http.post(
        '$url/api/auth/login?email=${log['email']}&password=${log['password']}');
    print(jsonDecode(re.body));
    Map data = jsonDecode(re.body);
    if (data['status']) {
      user = User.fromMap(data['data']);
      print(user.name);
    }
    return jsonDecode(re.body);
  } catch (e) {
    print(e);
    return {'status': false, 'message': 'verify your Connection!'};
  }
}
