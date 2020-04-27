import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/utilts/constant.dart';
import '../models/unit.dart';
import 'package:http/http.dart' as http;

class PropertiesRepository {
  static final _obj = PropertiesRepository._internal();
  PropertiesRepository._internal();
  factory PropertiesRepository() {
    return _obj;
  }
  UserRepository _userRepository = UserRepository();
  Constant _constant = Constant();
  List<Post> userProperites;
  List<Post> availbale = [];
  List<Post> sold = [];
  bool propertiesFetch = false;
  Map<String, dynamic> homeData;
  List<Unit> chatDataCurrent;
  List<Unit> chatDataLast;
  int soldCount = 0;
  int availCount = 0;
  int rentCount = 0;
  int earned = 0;
  int count = 0;
  int max = 1;
  // Agency Properties;
  getProperties() async {
    try {
      var _re = await http.get(
          '${_constant.url}//api/posts/user_posts/${_userRepository.user.id}');
      var _converted = jsonDecode(_re.body);
      print(_converted);
      print(_converted['data'].length);
      if (_converted['status']) {
        userProperites = [];
        availbale = [];
        sold = [];
        for (var item in _converted['data']['posts']) {
          userProperites.add(Post.fromMap(item));
          if (item['sold'] == 1) {
            sold.add(Post.fromMap(item));
          } else {
            availbale.add(Post.fromMap(item));
          }
        }
        print('avalibale = ${availbale.length}');
        print('sold = ${sold.length}');

        return {'status': true};
      }

      return _converted;
    } catch (e) {
      print(e);
      return {'status': true, 'errors': e};
    }
  }

  // add a new Property
  Future addProperety(Map map) async {
    print(map['imgs']);
    var re = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${_constant.url}/api/posts/add_post?des=${map['description']}&price=${map['price']}&type=${map['type']}&finance_availab=${map['finance_availab']}&land_location=${map['lang']}&lant_location=${map['lant']}&category_id=2&bed_rooms=${map['bed_rooms']}&bath_rooms=${map['bath_rooms']}&area=${map['area']}&user_id=${_userRepository.user.id}'));

    for (var item in map['imgs']) {
      var pic = await http.MultipartFile.fromPath(
          'imgs[]', item.toString().split('\'')[1],
          filename: 'pic-name.png');
      re.files.add(pic);
    }
    try {
      var response = await re.send();
      var responseData = await response.stream.toBytes();
      var responseString = jsonDecode(String.fromCharCodes(responseData));
      print(responseString);
      if (responseString['status']) {
        availbale.add(Post.fromMap(responseString['data']));
        return {'status': responseString['status'], 'errors': null};
      } else {
        return {'status': false, 'errors': responseString['errors']};
      }
    } catch (e) {
      print(e);

      return {'status': false, 'errors': 'varify your connection!'};
    }
  }

  // deleteProperty()

  // get home data

  Future<Map<String, dynamic>> getAgencyHome() async {
    try {
      var re = await http.get('${_constant.url}/api/agancy/home_data/1');
      var converted = jsonDecode(re.body);
      chatDataCurrent = [];
      chatDataLast = [];
      for (int i = 0;
          i < converted['data']['months_data']['current'].length;
          i++) {
        if (converted['data']['months_data']['current'][i]['cost'] > max) {
          max = converted['data']['months_data']['current'][i]['cost'];
        }

        chatDataCurrent.add(
            Unit.fromMap(converted['data']['months_data']['current'][i], i));
      }
      for (int i = 0;
          i < converted['data']['months_data']['last'].length;
          i++) {
        chatDataLast
            .add(Unit.fromMap(converted['data']['months_data']['last'][i], i));
      }
      soldCount = converted['data']['sold_count'];
      availCount = converted['data']['avail_count'];
      rentCount = converted['data']['rent_count'];
      earned = converted['data']['earned'];
      max += 10;
      return {'status': true, 'error': null};
    } catch (e) {
      print(e);
      return {'status': false, 'error': 'varify your connection!'};
    }
  }
}
