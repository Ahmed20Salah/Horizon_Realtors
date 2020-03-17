import 'dart:convert';

import 'package:horizon_realtors/models/post.dart';
import 'package:horizon_realtors/utilts/constant.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  static final _instance = PostsRepository._internal();
  PostsRepository._internal();
  factory PostsRepository() {
    return _instance;
  }
  List<Post> posts = [];
  getPosts() async {
    try {
      var re = await http.get('$url/api/posts/all_posts');
      var data = jsonDecode(re.body);
      if (data['status']) {
        print(data['data']);
        data['data'].forEach((ele) {
          posts.add(Post.fromMap(ele));
        });
        return {
          'status': true,
        };
      }
    } catch (e) {
      print(e);
      return {'status': false, 'message': 'Verify your connection!'};
    }
  }
  // getFavorite()async{
  //   try {
  //     var re = await http.get('$url/api/posts/all_posts');
  //     var data = jsonDecode(re.body);
  //     if (data['status']) {
  //       print(data['data']);
  //       data['data'].foreach((ele) {
  //         posts.add(Post.fromMap(ele));
  //       });
  //       return {
  //         'status': true,
  //       };
  //     }
  //   } catch (e) {
  //     print(e);
  //     return {'status': false, 'message': 'Verify your connection!'};
  //   }
  // }
}
