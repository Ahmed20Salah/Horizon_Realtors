import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/utilts/constant.dart';
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

  // Agency Properties
  getProperties() async {
    print(_userRepository.user.id);
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
        for (var item in _converted['data']) {
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
    // try {
    var re = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${_constant.url}/api/posts/add_post?des=${map['description']}&price=${map['price']}&type=${map['type']}&finance_availab=${map['availbale']}&land_location=${map['lang']}&lant_location=${map['lant']}&category_id=2&bed_rooms=${map['bedrooms']}&bath_rooms=${map['bathrooms']}&area=${map['area']}&user_id=${_userRepository.user.id}'));

    for (var item in map['imgs']) {
      var pic = await http.MultipartFile.fromPath(
          'imgs[]', item.toString().split('\'')[1],
          filename: 'pic-name.png');
      re.files.add(pic);
    }

    var response = await re.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    // print(re.body);
    // } catch (e) {
    //   print(e);
    // }
  }
}
