import 'dart:convert';

import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/repository/user_repo.dart';
import 'package:horizon_realtors/utilts/constant.dart';
import 'package:http/http.dart' as http;

class AgencyRepository {
  static final _obj = AgencyRepository._internal();
  AgencyRepository._internal();
  factory AgencyRepository() {
    return _obj;
  }
  UserRepository _userRepository = UserRepository();
  Constant _constant = Constant();
  List<Post> userProperites;
  List<Post> availbale = [];
  List<Post> sold = [];
  bool propertiesFetch = false;
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
}
