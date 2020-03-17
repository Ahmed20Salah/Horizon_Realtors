import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizon_realtors/repository/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  @override
  PostsState get initialState => PostsInitial();
  PostsRepository _postsRepository = PostsRepository();
  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is GetPosts) {
      yield Loading();
     var re = await _postsRepository.getPosts();
     if(re['status']){
       yield HasData();
     }
     else{
       yield Error();
     }
    }
  }
}
